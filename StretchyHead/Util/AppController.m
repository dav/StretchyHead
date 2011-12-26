//
//  AppController.m
//  StretchyHead
//
//  Created by dav on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "FoursquarePrivate.h"

SINGLETON_IMPLEMENTATION(AppController)

@interface AppController ()
@property (nonatomic,strong) BZFoursquareRequest* fsqRequest;
@property (nonatomic,copy) NSDictionary *fsqMeta;
@property (nonatomic,copy) NSArray *fsqNotifications;
@property (nonatomic,copy) NSDictionary *fsqResponse;
- (void) cancelRequest;
- (void) prepareForRequest;
@end

@implementation AppController

@synthesize foursquare = _foursquare;
@synthesize fsqRequest = _fsqRequest;
@synthesize fsqMeta = _fsqMeta;
@synthesize fsqNotifications = _fsqNotifications;
@synthesize fsqResponse = _fsqResponse;

- (id) init {
  self = [super init];
  if (self) {
    _foursquare = [[BZFoursquare alloc] initWithClientID:FOURSQUARE_CLIENT_ID callbackURL:@"stretchyhead://foursquare"];
    _foursquare.version = @"20111119";
    _foursquare.locale = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    _foursquare.sessionDelegate = self;
    
    NSString* storedAccessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"FSQAT"];
    if (storedAccessToken) {
      _foursquare.accessToken = storedAccessToken;
    }
  }
  return self;
}

- (void) dealloc {
  [_foursquare release];
  [super dealloc];
}

#pragma mark -
#pragma mark Foursquare Private Methods

- (void)cancelRequest {
  if (_fsqRequest) {
    _fsqRequest.delegate = nil;
    [_fsqRequest cancel];
    self.fsqRequest = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }
}

- (void)prepareForRequest {
  [self cancelRequest];
  self.fsqMeta = nil;
  self.fsqNotifications = nil;
  self.fsqResponse = nil;
}

#pragma mark -
#pragma mark BZFoursquareRequestDelegate

- (void)requestDidFinishLoading:(BZFoursquareRequest *)request {
  NSLog(@"%s: %@", __PRETTY_FUNCTION__, request);
  self.fsqMeta = request.meta;
  self.fsqNotifications = request.notifications;
  self.fsqResponse = request.response;
  self.fsqRequest = nil;
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) request:(BZFoursquareRequest*)request didFailWithError:(NSError *)error {
  NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[error userInfo] objectForKey:@"errorDetail"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
  [alertView show];
  self.fsqMeta = request.meta;
  self.fsqNotifications = request.notifications;
  self.fsqResponse = request.response;
  self.fsqRequest = nil;
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark BZFoursquareSessionDelegate

- (void)foursquareDidAuthorize:(BZFoursquare *)foursquare {
  NSLog(@"%s: %@", __PRETTY_FUNCTION__, foursquare);
  
  // TODO store to secure keychain before production release
  [[NSUserDefaults standardUserDefaults] setValue:foursquare.accessToken forKey:@"FSQAT"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)foursquareDidNotAuthorize:(BZFoursquare *)foursquare error:(NSDictionary *)errorInfo {
  NSLog(@"%s: %@", __PRETTY_FUNCTION__, errorInfo);
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Foursquare Error" message:[errorInfo objectForKey:@"errorDetail"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
  [alertView show];

}



@end

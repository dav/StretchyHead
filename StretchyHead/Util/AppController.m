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
  }
  return self;
}

- (void) dealloc {
  [_foursquare release];
  [super dealloc];
}

#pragma mark -
#pragma mark BZFoursquareRequestDelegate

- (void)requestDidFinishLoading:(BZFoursquareRequest *)request {
  NSLog(@"%@: %@", __PRETTY_FUNCTION__, request);
  self.fsqMeta = request.meta;
  self.fsqNotifications = request.notifications;
  self.fsqResponse = request.response;
  self.fsqRequest = nil;
//  [self updateView];
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
//  [self updateView];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark BZFoursquareSessionDelegate

- (void)foursquareDidAuthorize:(BZFoursquare *)foursquare {
  NSLog(@"%@: %@", __PRETTY_FUNCTION__, foursquare);
////  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kAccessTokenRow inSection:kAuthenticationSection];
//  NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
//  [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (void)foursquareDidNotAuthorize:(BZFoursquare *)foursquare error:(NSDictionary *)errorInfo {
  NSLog(@"%s: %@", __PRETTY_FUNCTION__, errorInfo);
}

@end

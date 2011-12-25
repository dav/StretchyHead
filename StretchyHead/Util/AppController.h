//
//  AppController.h
//  StretchyHead
//
//  Created by dav on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZFoursquare.h"

@interface AppController : NSObject <BZFoursquareRequestDelegate, BZFoursquareSessionDelegate> {
  BZFoursquare* _foursquare;
  
  BZFoursquareRequest *_fsqRequest;
  NSDictionary        *_fsqMeta;
  NSArray             *_fsqNotifications;
  NSDictionary        *_fsqResponse;
}

@property (nonatomic,readonly,strong) BZFoursquare* foursquare;

@end

SINGLETON_INTERFACE(AppController);

//
//  SHAppDelegate.h
//  StretchyHead
//
//  Created by dav on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GHSidebarViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow* window;
@property (strong, nonatomic) GHSidebarViewController* viewController;
@end

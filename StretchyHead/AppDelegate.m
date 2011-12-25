//
//  SHAppDelegate.m
//  StretchyHead
//
//  Created by dav on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AppController.h"
#import "GHSidebarViewController.h"
#import "BZFoursquare.h"
#import "StoryViewController.h"
#import "FSQViewController.h"
#import "StoriesManager.h"
#import "Story.h"

@interface AppDelegate ()
- (void) setUpSideNav;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc {
  [_window release];
  [_viewController release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  
  // Override point for customization after application launch.
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    [self setUpSideNav];
  } else {
    // init iPad xib
  }
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  
  [self.viewController toggleSidebar:YES animated:NO];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//  UINavigationController *navigationController = (UINavigationController *)window_.rootViewController;
//  FSQMasterViewController *masterViewController = [navigationController.viewControllers objectAtIndex:0];
  BZFoursquare *foursquare = [AppController sharedInstance].foursquare;
  return [foursquare handleOpenURL:url];
}


#pragma mark -

- (void) setUpSideNav {
	NSMutableArray *headers = [[NSMutableArray alloc] initWithCapacity:2];
	NSMutableArray *controllers = [[NSMutableArray alloc] initWithCapacity:2];
	NSMutableArray *cellInfos = [[NSMutableArray alloc] initWithCapacity:2];
	
  self.viewController = [[GHSidebarViewController alloc] initWithHeaders:headers withContollers:controllers withCellInfos:cellInfos];
  
	void (^revealBlock)() = ^(){
		[self.viewController toggleSidebar:!self.viewController.sidebarShowing animated:YES];
	};
	
  StoriesManager* storiesManager = [StoriesManager new];
  NSUInteger numStories = [storiesManager.stories count];
  
	NSMutableArray *storiesInfos = [[NSMutableArray alloc] initWithCapacity:numStories];
	NSMutableArray *storiesControllers = [[NSMutableArray alloc] initWithCapacity:numStories];
  
  for (Story* story in storiesManager.stories) {
    [storiesInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"user.png"], kSidebarCellImageKey, NSLocalizedString(story.title, @""), kSidebarCellTextKey, nil]];
    StoryViewController* bookVC = [[StoryViewController alloc] initWithStory:story withRevealBlock:revealBlock];
    bookVC.story = story;
    [storiesControllers addObject:[[UINavigationController alloc] initWithRootViewController:bookVC]];
  }
  [headers addObject:@"StretchyHead Stories"];
  [cellInfos addObject:storiesInfos];
  [controllers addObject:storiesControllers];
	
	NSMutableArray *utilsInfos = [[NSMutableArray alloc] initWithCapacity:1];
	NSMutableArray *utilsControllers = [[NSMutableArray alloc] initWithCapacity:5];
	[utilsInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"user.png"], kSidebarCellImageKey, NSLocalizedString(@"Foursquare", @""), kSidebarCellTextKey, nil]];
	[utilsControllers addObject:[[UINavigationController alloc] initWithRootViewController:[[FSQViewController alloc] initWithTitle:@"Foursquare" withRevealBlock:revealBlock]]];
	[headers addObject:@"Utils"];
	[cellInfos addObject:utilsInfos];
	[controllers addObject:utilsControllers];
}

@end

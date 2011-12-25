//
//  SHViewController.m
//  StretchyHead
//
//  Created by dav on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StoryViewController.h"
#import "StoryPageViewController.h"
#import "Story.h"

#pragma mark Private Interface
@interface StoryViewController ()
- (void)revealSidebar;
- (StoryPageViewController*) viewControllerAtIndex:(NSUInteger)index;
@end

@implementation StoryViewController

@synthesize pageController;
@synthesize story = _story;

- (id)initWithStory:(Story*)story withRevealBlock:(void (^)())revealBlock {
  if (self = [[StoryViewController alloc] initWithNibName:@"StoryViewController_iPhone" bundle:nil]) {
    self.story = story;
		self.title = story.title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem = 
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                  target:self 
                                                  action:@selector(revealSidebar)];
	}
	return self;
}

- (void)revealSidebar {
	((void (^)()) _revealBlock)();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _pages = [[NSArray alloc] initWithObjects:@"one", @"twp", nil];

  NSNumber* value = [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin];
  NSDictionary *options = [NSDictionary dictionaryWithObject:value forKey: UIPageViewControllerOptionSpineLocationKey];
  self.pageController = [[UIPageViewController alloc] 
                         initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                         options:options];
  
  pageController.dataSource = self;
  [[pageController view] setFrame:[[self view] bounds]];
  
  
  StoryPageViewController* initialViewController =  [self viewControllerAtIndex:0];
  NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
  
  [pageController setViewControllers:viewControllers  
                           direction:UIPageViewControllerNavigationDirectionForward 
                            animated:NO 
                          completion:nil];
  
  [self addChildViewController:pageController];
  [[self view] addSubview:[pageController view]];
  [pageController didMoveToParentViewController:self];  

}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}

#pragma mark - Pages

- (StoryPageViewController*) viewControllerAtIndex:(NSUInteger)index {
  // Return the data view controller for the given index.
  if (([_pages count] == 0) || 
      (index >= [_pages count])) {
    return nil;
  }
  
  // Create a new view controller and pass suitable data.
  StoryPageViewController* dataViewController = [[StoryPageViewController alloc] initWithNibName:@"StoryPageViewController" bundle:nil];
  dataViewController.data = [_pages objectAtIndex:index];
  return dataViewController;
}

- (NSUInteger) indexOfViewController:(StoryPageViewController*)viewController {
  return [_pages indexOfObject:viewController.data];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerBeforeViewController:(UIViewController*)viewController {
  NSUInteger index = [self indexOfViewController:(StoryPageViewController*)viewController];
  if ((index == 0) || (index == NSNotFound)) {
    return nil;
  }
  
  index--;
  return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController*)pageViewController viewControllerAfterViewController:(UIViewController*)viewController {
  NSUInteger index = [self indexOfViewController:(StoryPageViewController*)viewController];
  if (index == NSNotFound) {
    return nil;
  }
  
  index++;
  if (index == [_pages count]) {
    return nil;
  }
  return [self viewControllerAtIndex:index];
}

@end

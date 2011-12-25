//
//  SHViewController.h
//  StretchyHead
//
//  Created by dav on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Story;

@interface StoryViewController : UIViewController <UIPageViewControllerDataSource> {
  UIPageViewController* _pageViewController;
  NSArray* _pages;
  Story* _story;
@private
  id _revealBlock;
}

@property (strong, nonatomic) UIPageViewController *pageController;
@property (nonatomic, retain) Story* story;

- (id)initWithStory:(Story*)story withRevealBlock:(void (^)())revealBlock;

@end

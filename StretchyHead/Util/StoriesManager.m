//
//  StoriesManager.m
//  StretchyHead
//
//  Created by dav on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StoriesManager.h"
#import "Story.h"

@implementation StoriesManager 

@synthesize stories;

- (id) init {
  self = [super init];
  if (self) {
    self.stories = [NSArray arrayWithObjects:
                    [Story storyWithTitle:@"Chat's" andText:@"Mammood is Ojichan!"],
                    [Story storyWithTitle:@"Susie's Diner" andText:@"That's Cantonese, not Chinese"], 
                    nil];
  }
  return self;
}

@end

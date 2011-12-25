//
//  Story.m
//  StretchyHead
//
//  Created by dav on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Story.h"

@implementation Story

@synthesize title;
@synthesize text;

+ (Story*) storyWithTitle:(NSString*)title andText:(NSString*)text {
  Story* story = [[Story new] autorelease];
  story.title = title;
  story.text = text;
  return story;
}

@end

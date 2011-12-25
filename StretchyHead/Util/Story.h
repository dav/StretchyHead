//
//  Story.h
//  StretchyHead
//
//  Created by dav on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* text;

+ (id) storyWithTitle:(NSString*)title andText:(NSString*)text;

@end

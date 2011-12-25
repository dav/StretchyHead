//
//  FSQViewConroller.h
//  StretchyHead
//
//  Created by dav on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSQViewController : UIViewController {
@private
  id _revealBlock;
}

- (id)initWithTitle:(NSString *)title withRevealBlock:(void (^)())revealBlock;

@end

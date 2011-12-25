//
//  StoryPageViewController.h
//  StretchyHead
//
//  Created by dav on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryPageViewController : UIViewController <UIWebViewDelegate> {
  IBOutlet UIWebView* _webView;
  NSString* _data;
}

@property (nonatomic, retain) UIWebView* webView;
@property (nonatomic, retain) NSString* data;

@end

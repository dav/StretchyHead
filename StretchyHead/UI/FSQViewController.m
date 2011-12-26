//
//  FSQViewConroller.m
//  StretchyHead
//
//  Created by dav on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FSQViewController.h"
#import "AppController.h"

#pragma mark Private Interface
@interface FSQViewController ()
- (void)revealSidebar;
@end

@implementation FSQViewController

- (id)initWithTitle:(NSString *)title withRevealBlock:(void (^)())revealBlock {
  if (self = [[FSQViewController alloc] initWithNibName:@"FSQViewController" bundle:nil]) {
		self.title = title;
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

- (IBAction) buttonTapped:(id)sender {
  if (![[AppController sharedInstance].foursquare isSessionValid]) {
    [[AppController sharedInstance].foursquare startAuthorization];
  } else {
    [[AppController sharedInstance].foursquare invalidateSession];
  }
}

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
  if (![[AppController sharedInstance].foursquare isSessionValid]) {
    [_fsqButton setTitle:NSLocalizedString(@"Obtain Access Token", @"") forState:UIControlStateNormal];
  } else {
    [_fsqButton setTitle:NSLocalizedString(@"Forget Access Token", @"") forState:UIControlStateNormal];
  }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

	//
	//  TOSplitViewController.h
	//  TrustedOnes
	//
	//  Created by arno grbac on 6/27/10, http://trustedones.com
	//  Copyright 2010 Cerimbrium, Inc. All rights reserved.
	//
	//  License: MIT
	//
	//	Description: Master view always visible. Substitute for the UISplitViewController class.
	//
	//	Why?
	//		Apple will reject your app if you make a call to setHidesMasterViewInPortrait.
	//		The API method is private, so that's fine. I've tried subclassing the UISplitViewController
	//		and unteach it a few things. In the end, it was just a lot easier to write a split
	//		controller from the ground up.
	//
	//	For screenshots, see: http://trustedones.com/apps/ipad
	//

#import "TOSplitViewController.h"

static int MV_WIDTH  = 320.0;	// Main view width
static int SV_GAP    =   2.0;	// Gap size
static int SB_HEIGHT =  20.0;	// Status bar height

@implementation TOSplitViewController

@synthesize viewControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil panes:(NSArray *)panes{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.viewControllers = panes;
	}
	return self;
}
	//
	//
	// SETUP
	//
	//---------------------------------------------------------------------------------------- viewDidLoad
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.autoresizesSubviews=YES;
	
		// set split view "gap" color
	self.view.backgroundColor = [[[UIColor alloc] initWithWhite:0.2  alpha:1.0] autorelease];
	
	for (UIViewController *cv in viewControllers) {
		
		[self.view addSubview:cv.view];
		
		[cv viewDidLoad];
	}
}
	//---------------------------------------------------------------------------------------- viewDidAppear
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	for (UIViewController *cv in viewControllers) {
		[cv viewDidAppear:animated];
	}
}
	//---------------------------------------------------------------------------------------- viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self layoutViews:UIInterfaceOrientationPortrait initialVerticalOffset:SB_HEIGHT];
	
	for (UIViewController *cv in viewControllers) {
		[cv viewWillAppear:animated];
	}	
}

	//
	//
	// MODAL VIEWS - make sure you push and pop from here to avoid layout problems
	//
	//---------------------------------------------------------------------------------------- dismissModalViewControllerAnimated
- (void)dismissModalViewControllerAnimated:(BOOL)animated {
	[super dismissModalViewControllerAnimated:animated];
}

	//---------------------------------------------------------------------------------------- presentModalViewController
- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
	[super  presentModalViewController:modalViewController animated:animated];
}


- (void)layoutSubviews {
}
	//
	//
	// CHILD VIEW SIZING AND LAYOUT
	//
	//---------------------------------------------------------------------------------------- layoutViews
- (void)layoutViews:(UIInterfaceOrientation)orientation initialVerticalOffset:(float)offset {
	
	UIViewController *mvc = [self.viewControllers objectAtIndex:0];
	UIViewController *dvc = [self.viewControllers objectAtIndex:1];
	
		// get split view frame size, ..for things like a tab bar
	CGRect svf = self.view.frame;
	
		//
		// currently, starting the app in portrait mode and a status bar will fail to offset the view
		// this takes care of the problem, but it's not the way i like to code
		//
	if (offset > 0.0) {
		svf.origin.y = offset;
		[self.view setFrame:svf];
	}
	
	CGRect mvf = mvc.view.frame;
	CGRect dvf = dvc.view.frame;
	
	mvf.origin.x		= 0;
	mvf.origin.y		= 0;
	mvf.size.width  = MV_WIDTH;
	mvf.size.height = svf.size.height;
	
	[mvc.view setFrame:mvf];
	
	if (orientation==UIInterfaceOrientationLandscapeLeft || orientation==UIInterfaceOrientationLandscapeRight) {
		return; // the detail view will be properly sized, so don't mess with it
	}
		
	dvf.origin.x		= MV_WIDTH + SV_GAP;
	dvf.origin.y		= 0;
	dvf.size.width	= svf.size.width - MV_WIDTH - SV_GAP;
	dvf.size.height = svf.size.height;
	
	[dvc.view setFrame:dvf];
}

	//
	//
	// ROTATION
	//
	//---------------------------------------------------------------------------------------- shouldAutorotateToInterfaceOrientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {      
		return YES;
	} else {
		return (toInterfaceOrientation==UIInterfaceOrientationPortrait); //
	}
}
	//---------------------------------------------------------------------------------------- didRotateFromInterfaceOrientation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	
	for (UIViewController *cv in viewControllers) {
		[cv didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	}
}
	//---------------------------------------------------------------------------------------- willAnimateRotationToInterfaceOrientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
		//
	for (UIViewController *cv in viewControllers) {
		[cv willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	}
}
	//---------------------------------------------------------------------------------------- willAnimateRotationToInterfaceOrientation
- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
		//call super method
	[super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
		//
	[self layoutViews:interfaceOrientation initialVerticalOffset:0.0];
}


	//
	//
	// CLEANUP
	//
	//---------------------------------------------------------------------------------------- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
    // Release any cached data, images, etc that aren't in use.
}

	//---------------------------------------------------------------------------------------- viewDidUnload
- (void)viewDidUnload {
	[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

	//---------------------------------------------------------------------------------------- dealloc
- (void)dealloc {
	[super dealloc];
}
@end

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

#import <UIKit/UIKit.h>


@interface TOSplitViewController : UIViewController {

	NSArray *viewControllers;
	
}

@property (nonatomic, retain) NSArray *viewControllers;

	//
	// initialVerticalOffset: vertical offset for initial rendering in portrait mode
	//
- (void)layoutViews:(UIInterfaceOrientation)orientation initialVerticalOffset:(float)offset;

	//
	// initialize from a nib with panes. therefore, the pane controllers must exist at this point
	//
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil panes:(NSArray *)panes;

@end

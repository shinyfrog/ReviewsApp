//
//  StoreSelectionControllerPad.m
//  reviewApp
//
//  Created by Danilo Bonardi on 15/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "StoreSelectionControllerPad.h"
#import "reviewAppIpadDelegate.h"
#import "ReviewsManager.h"
#import "RootViewControllerPad.h"

@implementation StoreSelectionControllerPad

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) viewDidLoad {
    
    self.title = @"Select the stores";
    
	//[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_back.png"] withBackgroundTint:[UIColor grayColor]];    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.451 green:0.518 blue:0.616 alpha:1.000]];    
    
	UIImageView *tableBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_back.png"]] autorelease];
	[self.tableView setBackgroundView:tableBg];    
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButtonArrow.png"] 
                                                                    style:self.navigationItem.backBarButtonItem.style
                                                                   target:self.navigationItem.backBarButtonItem.target 
                                                                   action:self.navigationItem.backBarButtonItem.action] autorelease];
    self.navigationItem.backBarButtonItem = backButton;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];

}

- (void) addStoresEnded {

    [self.navigationController popToRootViewControllerAnimated:YES];

    reviewAppIpadDelegate* app = [[UIApplication sharedApplication] delegate];

    //[app.leftNav popToRootViewControllerAnimated:YES];
    
    RootViewControllerPad* aViewController = (RootViewControllerPad*)app.leftNav.topViewController;
    [aViewController viewWillAppear:NO];

}

@end

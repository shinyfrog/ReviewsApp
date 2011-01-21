//
//  SearchAppViewControllerPad.m
//  reviewApp
//
//  Created by Danilo Bonardi on 15/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "SearchAppViewControllerPad.h"
#import "StoreSelectionControllerPad.h"
#import "reviewAppIpadDelegate.h"

@implementation SearchAppViewControllerPad

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (IBAction) addApplication {
    
    NSString* appid = [appidTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([appid length] == 0) { return; }
    
    StoreSelectionControllerPad* ssc = [[[StoreSelectionControllerPad alloc] initWithNibName:@"StoreSelectController" bundle:nil father:father appId:appid] autorelease];
    ssc.appLink = self.appLink;
    [self.navigationController pushViewController:ssc animated:YES];
    
}

- (IBAction) cancelOperation {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}

- (void) viewDidLoad {
    
    self.title = @"Add an App";
    /*
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_back.png"] withBackgroundTint:[UIColor grayColor]];    
     */
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.451 green:0.518 blue:0.616 alpha:1.000]];

    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButtonArrow.png"]
                                                                    style:self.navigationItem.backBarButtonItem.style
                                                                   target:self.navigationItem.backBarButtonItem.target
                                                                   action:self.navigationItem.backBarButtonItem.action] autorelease];
    self.navigationItem.backBarButtonItem = backButton;
    
    self.navigationItem.hidesBackButton = YES;
}

- (void) viewDidAppear:(BOOL)animated {
    
    reviewAppIpadDelegate* app = (reviewAppIpadDelegate*)[[UIApplication sharedApplication] delegate];
    RootViewControllerPad* root = [app.leftNav.viewControllers objectAtIndex:0];
    
    if ([root tableView:(UITableView*)root.view numberOfRowsInSection:0] != 0) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelOperation)];
        self.navigationItem.rightBarButtonItem = addButton;
        [addButton release];
    }
    
}

@end

//
//  SearchAppViewController.m
//  reviewApp
//
//  Created by Danilo Bonardi on 21/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "SearchAppViewController.h"
#import "RootViewController.h"
#import "models.h"
#import "reviewAppAppDelegate.h"
#import "StoreSelectionController.h"
#import "UINavigationBar+BackgroundImage.h"
#import "SearchCell.h"
#import "SearchOperation.h"

@implementation SearchAppViewController

@synthesize searchResults, searchQueue, appLink;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil father:(id)_father {
    
    if (![super initWithNibName:nibName bundle:bundleOrNil]) {
        return nil;
    }

    father = _father;
    self.searchQueue = [[[NSOperationQueue alloc] init] autorelease];
    [self.searchQueue setMaxConcurrentOperationCount:1];
    self.appLink = @"";
    
    return self;
}

- (void) viewDidLoad {
    
    self.title = @"Add an App";
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_back.png"] withBackgroundTint:[UIColor grayColor]];    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.451 green:0.518 blue:0.616 alpha:1.000]];
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButtonArrow.png"] 
                                                                    style:self.navigationItem.backBarButtonItem.style
                                                                   target:self.navigationItem.backBarButtonItem.target 
                                                                   action:self.navigationItem.backBarButtonItem.action] autorelease];
    self.navigationItem.backBarButtonItem = backButton;

}

- (void) viewDidAppear:(BOOL)animated {
    
    RootViewController* root = (RootViewController*)father;
    
    if ([root tableView:root.tableView numberOfRowsInSection:0] != 0) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelOperation)];
        self.navigationItem.rightBarButtonItem = addButton;
        [addButton release];
    }

}

#pragma mark -
#pragma mark Search Display Controller

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView { }

#pragma mark -
#pragma mark Search Field methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {

    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	UIImageView *tableBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_back.png"]] autorelease];
	[self.searchDisplayController.searchResultsTableView setBackgroundView:tableBg];    
    self.searchDisplayController.searchResultsTableView.rowHeight = 44;    
    self.searchDisplayController.searchResultsTableView.tableFooterView = tableFooter;
    
    if ([searchString length] < 3) {
        self.searchResults = [NSArray array];
        return YES;
    }
    
    SearchOperation* op = [[[SearchOperation alloc] init] autorelease];
    op.father = self;
    op.searchString = searchString;
    [self.searchQueue addOperation:op];

    return YES;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    textField.placeholder = @"Application ID";
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.placeholder = @"";
    return YES;
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResults count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    

    SearchCell *cell = (SearchCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if (cell == nil) {
        UIViewController* adc = [[[UIViewController alloc] initWithNibName:@"SearchCell" bundle:nil] autorelease];        
        cell = (SearchCell *)adc.view;
    }

    NSDictionary* data = [self.searchResults objectAtIndex:indexPath.row];    
    cell.applicationNameLabel.text = [data objectForKey:@"titleNoFormatting"];
    
	cell.imageView.contentMode = UIViewContentModeTopLeft;
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == [self tableView:_tableView numberOfRowsInSection:0] -1) {
		return 42;
	}
	return 44;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary* data = [self.searchResults objectAtIndex:indexPath.row];    
    NSString* appid = [data objectForKey:@"appid"];
    
    appidTextField.text = appid;
    self.appLink = [data objectForKey:@"url"];
    
    [self.searchDisplayController setActive:NO animated:YES];
    
}


#pragma mark -
#pragma mark actions

- (IBAction) addApplication {
    
    NSString* appid = [appidTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if ([appid length] == 0) { return; }
    
    StoreSelectionController* ssc = [[[StoreSelectionController alloc] initWithNibName:@"StoreSelectController" bundle:nil father:father appId:appid] autorelease];
    ssc.appLink = self.appLink;
    [self.navigationController pushViewController:ssc animated:YES];

}

- (IBAction) cancelOperation {
    [father dismissModalViewControllerAnimated:YES];
}

@end

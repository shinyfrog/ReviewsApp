//
//  RootViewControllerPad.m
//  reviewApp
//
//  Created by Danilo Bonardi on 14/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "RootViewControllerPad.h"
#import "SearchAppViewControllerPad.h"
#import "reviewAppIpadDelegate.h"
#import "models.h"
#import "AppDetailsControllerPad.h"
#import "UINavigationBar+BackgroundImage.h"
#import "ApplicationCell.h"
#import "EGORefreshTableHeaderView.h"
#import "ReviewsManager.h"
#import "PullRefreshOperation.h"
#import "ReviewsControllerPad.h"

@interface RootViewControllerPad (Private)

- (void)dataSourceDidFinishLoadingNewData;

@end

@implementation RootViewControllerPad


@synthesize fetchedResultsController=fetchedResultsController_;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];

    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.451 green:0.518 blue:0.616 alpha:1.000]];    
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_back.png"] withBackgroundTint:kSCNavigationBarTintColor];
    
    self.title = @"Applications";
    
	UIImageView *tableBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_back.png"]] autorelease];
    
	[self.tableView setBackgroundView:tableBg];

    /*
    if ([self.fetchedResultsController.fetchedObjects count] == 0) {
        SearchAppViewController* addAppView = [[[SearchAppViewController alloc] initWithNibName:@"SearchAppViewController" bundle:nil father:self] autorelease];

        UINavigationController *controller = [[[UINavigationController alloc] initWithRootViewController:addAppView] autorelease];
        [[self navigationController] presentModalViewController:controller animated:NO];
    }
    */

    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButtonArrow.png"]
                                                                    style:self.navigationItem.backBarButtonItem.style
                                                                   target:self.navigationItem.backBarButtonItem.target 
                                                                   action:self.navigationItem.backBarButtonItem.action] autorelease];
    self.navigationItem.backBarButtonItem = backButton;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
}


- (void)viewWillAppear:(BOOL)animated {
    fetchedResultsController_ = nil;
    [self fetchedResultsController];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject {
    
    reviewAppIpadDelegate* app = [[UIApplication sharedApplication] delegate];
    BOOL animated = YES;

    if (![app.rightNav.visibleViewController isKindOfClass:[ReviewsControllerPad class]]) {
        
        if ([app.rightNav.visibleViewController isKindOfClass:[SearchAppViewControllerPad class]]) {
            animated = NO;            
        }
        
        [app.rightNav popToRootViewControllerAnimated:NO];
        
    }
    
    SearchAppViewControllerPad* addAppView = [[[SearchAppViewControllerPad alloc] initWithNibName:@"SearchAppViewControllerPad" bundle:nil father:self] autorelease];
    
    [app.rightNav pushViewController:addAppView animated:animated];
    
    //[self presentModalViewController:addAppView animated:YES];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView { return 1; }


- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionInfo = [self.fetchedResultsController sections];
    
    NSUInteger count = 0;
    if ([sectionInfo count]) {
        id <NSFetchedResultsSectionInfo> sectionsInfo = [sectionInfo objectAtIndex:section];
        count = [sectionsInfo numberOfObjects];
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"ApplicationCell";
    
    ApplicationCell *cell = (ApplicationCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController* adc = [[[UIViewController alloc] initWithNibName:@"ApplicationCell" bundle:nil] autorelease];        
        cell = (ApplicationCell *)adc.view;
    }
    
    App *app = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.applicationNameLabel.text = app.name;
    cell.applicationIconImageView.image = [UIImage imageWithContentsOfFile:app.image];
    
    int unreadCount = 0;
    int allreviews = 0;
    int stars = 0;
    
    for (AppStore* as in app.stores) {        
        for (Review* rev in as.reviews) {
            if (![rev.viewed boolValue]) { unreadCount++; }
            stars += [rev.stars intValue];
            allreviews++;
        }
    }
    
    if (allreviews != 0) {
        [cell setStars:stars/allreviews];
    }
    
    
    if (unreadCount != 0) {
        cell.badge.hidden = NO;
        [cell.badge setBadgeValue:unreadCount];
    } else {
        cell.badge.hidden = YES;
    }
	
	cell.imageView.contentMode = UIViewContentModeTopLeft;

    return cell;     

}


- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == [self tableView:_tableView numberOfRowsInSection:0] -1) {
		return 78;
	}
	return 80;
	
}

 
- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        
        
        App* app = (App*)[self.fetchedResultsController objectAtIndexPath:indexPath];
        for (AppStore* as in app.stores) {
            for (Review* rev in as.reviews) {
                [context deleteObject:rev];
            }
            [context deleteObject:as];
        }
        
        [context deleteObject:app];
        
        NSError *error = nil;
        
        
        if (![context save:&error]) {
            SFLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [_tableView beginUpdates];
        
        fetchedResultsController_ = nil;
        [self fetchedResultsController];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                          withRowAnimation:UITableViewRowAnimationFade];
        
        [_tableView endUpdates];
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath { 
    return YES; 
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
    return YES; 
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    App *application = [self.fetchedResultsController objectAtIndexPath:indexPath];    
    AppDetailsControllerPad* adc = [[[AppDetailsControllerPad alloc] initWithNibName:@"AppDetailsControllerPad" bundle:nil application:application] autorelease];
    
    [self.navigationController pushViewController:adc animated:YES];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}



#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) { return fetchedResultsController_; }
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    reviewAppAppDelegate* app = [[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"App" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"order" ascending:NO] autorelease];
    NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, nil] autorelease];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                 managedObjectContext:app.managedObjectContext
                                                                                                   sectionNameKeyPath:nil
                                                                                                            cacheName:nil] autorelease];
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        SFLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController_;
}


#pragma mark -
#pragma mark pull to refresh

- (void)reloadTableViewDataSource {
    
    reviewAppAppDelegate* app = (reviewAppAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    PullRefreshOperation* op = [[[PullRefreshOperation alloc] init] autorelease];
    op.father = self;
    [app.pullToRefreshQueue addOperation:op];
    
}

- (void) syncTask {
    @try {
        [ReviewsManager syncAllApps];
        fetchedResultsController_ = nil;
        [self.tableView reloadData];
    } @catch (NSException * e) {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Unable to refresh" 
                                                         message:@"Please try again later"
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil] autorelease];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    
    [self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];    
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	//refreshHeaderView=nil;
}

- (void)dealloc {
    [fetchedResultsController_ release];
    [super dealloc];
}

@end

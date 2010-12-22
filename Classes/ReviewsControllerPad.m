//
//  ReviewsControllerPad.m
//  reviewApp
//
//  Created by Danilo Bonardi on 16/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "ReviewsControllerPad.h"
#import "ReviewCellPad.h"
#import "models.h"
#import "reviewAppAppDelegate.h"

@implementation ReviewsControllerPad

@synthesize fetchedResultsController=fetchedResultsController_;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView { return 1; }


- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil {
    if (![super initWithNibName:nibName bundle:bundleOrNil]) {
        return nil;
    }

    return self;
}

- (void) viewDidLoad {

    self.navigationController.navigationBarHidden = YES;
    cellToExpand = nil;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self willRotateToInterfaceOrientation:[UIDevice currentDevice].orientation duration:0];
}


- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section { 
    NSArray *sectionInfo = [self.fetchedResultsController sections];
    
    NSUInteger count = 0;
    if ([sectionInfo count]) {
        id <NSFetchedResultsSectionInfo> sectionsInfo = [sectionInfo objectAtIndex:section];
        count = [sectionsInfo numberOfObjects];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath == cellToExpand) {
        return 200;
    }
    
	return 131;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReviewCellPad *cell = (ReviewCellPad *)[_tableView dequeueReusableCellWithIdentifier:@"ReviewCellPad"];
    if (cell == nil) {
        UIViewController* adc = [[[UIViewController alloc] initWithNibName:@"ReviewCellPad" bundle:nil] autorelease];        
        cell = (ReviewCellPad *)adc.view;        
    }
    
    Review *review = (Review *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.reviewTitle.text = review.title;
    cell.reviewComment.text = review.message;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    cellToExpand = [indexPath copy];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:cellToExpand] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) { return fetchedResultsController_; }
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    reviewAppAppDelegate* _app = [[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Review" inManagedObjectContext:_app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"insertionDate" ascending:NO] autorelease];
    NSSortDescriptor *sortDescriptor2 = [[[NSSortDescriptor alloc] initWithKey:@"storeOrder" ascending:YES] autorelease];


    NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, nil] autorelease];
    NSArray *sortDescriptors2 = [[[NSArray alloc] initWithObjects:sortDescriptor, sortDescriptor2, nil] autorelease];    
    
    if (appStore != nil) {
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"appstore.app.appId = %@ AND appstore.store.storeID = %@", 
                                  appStore.app.appId, appStore.store.storeID];
        [fetchRequest setPredicate:predicate];


        [fetchRequest setSortDescriptors:sortDescriptors2];
        
    } else if (app != nil) {

        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"appstore.app.appId = %@", 
                                  app.appId];
        [fetchRequest setPredicate:predicate];
        [fetchRequest setSortDescriptors:sortDescriptors];        
        
    } else {

        [fetchRequest setSortDescriptors:sortDescriptors];
        [fetchRequest setFetchLimit:1000];

    }

    
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                 managedObjectContext:_app.managedObjectContext
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

- (void)loadAllReviews {
    app = nil;
    appStore = nil;
    [self performSelector:@selector(refresh)];
}

- (void)loadAllReviewsForApp:(App*)_app {
    app = [_app retain];
    appStore = nil;
    [self performSelector:@selector(refresh)];
}

- (void)loadAllReviewsForAppStore:(AppStore*)_appStore {
    app = nil;
    appStore = [_appStore retain];
    [self performSelector:@selector(refresh)];
}

- (void) refresh {
    
    fetchedResultsController_ = nil;
    [self fetchedResultsController];
    [self.tableView reloadData];
    
    if ([self tableView:self.tableView numberOfRowsInSection:0] != 0) {    
        NSIndexPath* top = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }    
    
}

@end

//
//  StoreReviewsController.m
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "StoreReviewsController.h"
#import "models.h"
#import "ReviewDetailsController.h"
#import "ReviewCell.h"
#import "UINavigationBar+BackgroundImage.h"
#import "reviewAppAppDelegate.h"
#import "ReviewsManager.h"
#import "PullRefreshOperation.h"

@implementation StoreReviewsController

@synthesize store, fetchedResultsController=fetchedResultsController_;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil store:(AppStore*)_store {
    
    if (![super initWithNibName:nibName bundle:bundleOrNil]) {
        return nil;
    }

    self.store = _store;
    
    return self;
}

- (void) viewDidLoad {
    self.title = @"Store Details";

    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButtonArrow.png"] 
                                                                    style:self.navigationItem.backBarButtonItem.style
                                                                   target:self.navigationItem.backBarButtonItem.target 
                                                                   action:self.navigationItem.backBarButtonItem.action] autorelease];
    self.navigationItem.backBarButtonItem = backButton;
    
	UIImageView *tableBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_back.png"]] autorelease];
	[self.tableView setBackgroundView:tableBg];
    
    appNameLabel.text = self.store.app.name;
    storeNameLabel.text = [self.store.store.countryCode uppercaseString];
    AppIconImageView.image = [UIImage imageWithContentsOfFile:self.store.app.image];
    StoreIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@30.png", self.store.store.countryCode]];
    
    NSArray* ivstars = [NSArray arrayWithObjects:star1, star2, star3, star4, star5, nil];
    
    for (UIImageView* ivstar in ivstars) {
        ivstar.image = [UIImage imageNamed:@"emptyStar.png"];
    }

    float stars = 0;
    if ([self.store.stars floatValue] != 0) {
        stars = [self.store.stars floatValue];
    } else {
        int allreviews = 0;
        for (Review* rev in self.store.reviews) {
            stars += [rev.stars intValue];
            allreviews++;
        }
        stars = stars / allreviews;
    }
    
    NSNumber* nsfloat = [NSNumber numberWithFloat:stars];
    
    int i=0;
    for (; i<[nsfloat intValue]; i++) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"fullStar.png"];
    }
    
    if (i < 5 && (i+1)-[nsfloat floatValue] == 0.5) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"halfStar.png"];
    }
    
    [super viewDidLoad];        
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setTintColor:kSCNavigationBarTintColor];
    
    UIImageView *imageView = (UIImageView *)[[navBar viewWithTag:kSCNavigationBarBackgroundImageTag] retain];
    [imageView removeFromSuperview];
    
    [navBar insertSubview:imageView atIndex:0]; 
    
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

    ReviewCell *cell = (ReviewCell*)[_tableView dequeueReusableCellWithIdentifier:@"ReviewCell"];
    if (cell == nil) {
        UIViewController* adc = [[[UIViewController alloc] initWithNibName:@"ReviewCell" bundle:nil] autorelease];
        cell = (ReviewCell *)adc.view;
    }

    Review *review = (Review *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    //Review *review = [[self.store.reviews allObjects] objectAtIndex:indexPath.row];

    if (![review.viewed boolValue]) {
        cell.reviewTitle.textColor = [UIColor colorWithRed:0.32 green:0.43 blue:0.6 alpha:1.0];
    } else {
        cell.reviewTitle.textColor = [UIColor colorWithRed:0.28 green:0.29 blue:0.33 alpha:1.0];
    }

    cell.reviewTitle.text = review.title;
    [cell setStars:review.stars];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    sectionHeaderLabel.text = [NSString stringWithFormat:@"%d Reviews", [self.store.reviews count]];
    return sectionHeader;
    
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Review *review = (Review *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    //= [[self.store.reviews allObjects] objectAtIndex:indexPath.row];
    
    ReviewDetailsController* rdc = [[[ReviewDetailsController alloc] initWithNibName:@"ReviewDetailsController" bundle:nil review:review] autorelease];
    
    [self.navigationController pushViewController:rdc animated:YES];
}

- (IBAction) markAllAsReaded:(id)sender {
    
    for (Review* rev in self.store.reviews) {
        rev.viewed = [NSNumber numberWithBool:YES];
    }
    
    [self.tableView reloadData];
    
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) { return fetchedResultsController_; }
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    reviewAppAppDelegate* app = [[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Review" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"insertionDate" ascending:NO] autorelease];
    NSSortDescriptor *sortDescriptor2 = [[[NSSortDescriptor alloc] initWithKey:@"storeOrder" ascending:YES] autorelease];
    NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, sortDescriptor2, nil] autorelease];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"appstore.app.appId = %@ AND appstore.store.storeID = %@", 
                              self.store.app.appId, self.store.store.storeID];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                 managedObjectContext:app.managedObjectContext
                                                                                                   sectionNameKeyPath:nil
                                                                                                            cacheName:nil] autorelease];
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    @try {
        [ReviewsManager getReviewsForAppStore:self.store];
        fetchedResultsController = nil;
        [self.tableView reloadData];
    } @catch (NSException * e) {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Unable to refresh" 
                                                         message:@"Please try again later"
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil] autorelease];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;    
    [self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];    
}

@end

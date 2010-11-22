//
//  AppDetailsController.m
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "AppDetailsController.h"
#import "StoreReviewsController.h"
#import "UINavigationBar+BackgroundImage.h"
#import "AppStoreCell.h"
#import "StoreSelectionController.h"
#import "reviewAppAppDelegate.h"
#import "ReviewsManager.h"
#import "PullRefreshOperation.h"

@implementation AppDetailsController

@synthesize application, fetchedResultsController=fetchedResultsController_;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil application:(App*)_app {
    
    if (![super initWithNibName:nibName bundle:bundleOrNil]) {
        return nil;
    }
    
    self.application = _app;

    return self;
}

- (void) viewDidLoad {
    
	UIImageView *tableBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_back.png"]] autorelease];
	[self.tableView setBackgroundView:tableBg];
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButtonArrow.png"] 
                                                                    style:self.navigationItem.backBarButtonItem.style
                                                                   target:self.navigationItem.backBarButtonItem.target 
                                                                   action:self.navigationItem.backBarButtonItem.action] autorelease];
    self.navigationItem.backBarButtonItem = backButton;    
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_back.png"] withBackgroundTint:kSCNavigationBarTintColor];    
    
    appNameLabel.text = self.application.name;
    AppIconImageView.image = [UIImage imageWithContentsOfFile:self.application.image];
    
    int unreadCount = 0;
    int allreviews = 0;
    int allstars = 0;
    
    for (AppStore* as in self.application.stores) {        
        for (Review* rev in as.reviews) {
            if (![rev.viewed boolValue]) { unreadCount++; }
            allstars += [rev.stars intValue];
            allreviews++;
        }
    }
    
    if (allreviews != 0) {
        
        float stars = allstars / allreviews;
        int i=0;

        NSArray* ivstars = [NSArray arrayWithObjects:star1, star2, star3, star4, star5, nil];    
        for (; i<stars; i++) {
            UIImageView* ivstar = [ivstars objectAtIndex:i];
            ivstar.image = [UIImage imageNamed:@"fullStar.png"];
        }
        
        if (i < 5 && (i+1)-stars >= 0.5) {
            UIImageView* ivstar = [ivstars objectAtIndex:i];
            ivstar.image = [UIImage imageNamed:@"halfStar.png"];
        }
    }
    
    self.title = @"App Details";    

    [super viewDidLoad];    
    
}

- (void)viewWillAppear:(BOOL)animated {    
    fetchedResultsController_ = nil;
    [self.tableView reloadData];    
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setTintColor:kSCNavigationBarTintColor];
    
    UIImageView *imageView = (UIImageView *)[[[navBar viewWithTag:kSCNavigationBarBackgroundImageTag] retain] autorelease];
    [imageView removeFromSuperview];
    
    
    if (self.application.link != nil && [self.application.link length] != 0) {    
        UIButton* shareInsideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareInsideButton setFrame:CGRectMake(0, 0, 26, 19)];
        [shareInsideButton addTarget:self action:@selector(actions:) forControlEvents:UIControlEventTouchUpInside];
        shareInsideButton.backgroundColor = [UIColor clearColor];
        shareInsideButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin; 
        [shareInsideButton setImage:[UIImage imageNamed:@"actionIcon.png"] forState:UIControlStateNormal];
        UIBarButtonItem* shareButton = [[UIBarButtonItem alloc] initWithCustomView:shareInsideButton];
        //[self.navigationItem setRightBarButtonItem:shareButton animated:YES];
        self.navigationItem.rightBarButtonItem = shareButton;
    }
    
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
    
    AppStoreCell *cell = (AppStoreCell *)[_tableView dequeueReusableCellWithIdentifier:@"AppStoreCell"];
    if (cell == nil) {
        UIViewController* adc = [[[UIViewController alloc] initWithNibName:@"AppStoreCell" bundle:nil] autorelease];        
        cell = (AppStoreCell *)adc.view;        
    }
    
    AppStore *astore = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.appStoreIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", astore.store.countryCode]];
    cell.appStoreNameLabel.text = astore.store.storeName;
    
    int revCount = [astore.reviews count];
    
    if (revCount == 1) {
        cell.appStoreReviewsLabel.text = @"1 Review";    
    } else {
        cell.appStoreReviewsLabel.text = [NSString stringWithFormat:@"%d Reviews", [astore.reviews count]];    
    }

    
    float stars = 0;
    int unreadCount = 0;
    int allreviews = 0;
    for (Review* rev in astore.reviews) {
        if (![rev.viewed boolValue]) { unreadCount++; }
        stars += [rev.stars intValue];
        allreviews++;
    }
    
    if ([astore.stars intValue] != 0) {
        stars = [astore.stars intValue];
    } else if (allreviews != 0) {
        stars = stars / allreviews;
    }

    [cell setStars:[NSNumber numberWithFloat:stars]];

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


#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    int count = 0;
    for (AppStore* as in self.application.stores) {
        count += [as.reviews count];
    }

    if (count == 1) {
        sectionHeaderLabel.text = @"1 Review";
    } else {
        sectionHeaderLabel.text = [NSString stringWithFormat:@"%d Reviews", count];
    }

    return sectionHeader;

}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //AppStore *astore = [[self.application.stores allObjects] objectAtIndex:indexPath.row];
    AppStore *astore = [self.fetchedResultsController objectAtIndexPath:indexPath];

    if ([astore.reviews count] == 0) { return; }
    
    StoreReviewsController* src = [[[StoreReviewsController alloc] initWithNibName:@"StoreReviewsController" bundle:nil store:astore] autorelease];
    
    [self.navigationController pushViewController:src animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
    return YES; 
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        reviewAppAppDelegate* delegate = (reviewAppAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.managedObjectContext;
        
        AppStore *astore = [self.fetchedResultsController objectAtIndexPath:indexPath];

        for (Review* rev in astore.reviews) {
            [context deleteObject:rev];
        }
        [context deleteObject:astore];

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


- (IBAction) editStores {
    
    StoreSelectionController* ssc = [[[StoreSelectionController alloc] initWithNibName:@"StoreSelectController" 
                                                                                bundle:nil 
                                                                                father:self 
                                                                                 appId:self.application.appId] autorelease];
    
    UINavigationController *controller = [[[UINavigationController alloc] initWithRootViewController:ssc] autorelease];
    [[self navigationController] presentModalViewController:controller animated:YES];
    
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) { return fetchedResultsController_; }
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    reviewAppAppDelegate* app = [[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AppStore" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"store.storeName" ascending:YES] autorelease];
    NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, nil] autorelease];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"app.appId = %@", self.application.appId];
    [fetchRequest setPredicate:predicate];
    
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
        [ReviewsManager newAppSync:self.application];
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
    
    [self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];    
}

#pragma mark -
#pragma mark actions

- (IBAction) actions:(id)sender {
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"Mark all as read", @"Open in iTunes", @"Copy iTunes link", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.navigationController.navigationBar];
    [popupQuery release];    

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ( buttonIndex == 0) {
        
        for (AppStore* astore in self.application.stores) {
            for (Review* rev in astore.reviews) {
                    rev.viewedValue = YES;
            }
        }
        
        [self.tableView reloadData];
        
    } else if (buttonIndex == 1) { // itunes
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.application.link]];
    } else if (buttonIndex == 2) { //clipboard
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.application.link;
    } 
}

@end

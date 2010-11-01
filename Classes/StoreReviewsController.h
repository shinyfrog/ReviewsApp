//
//  StoreReviewsController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "models.h"
#import "PullToRefreshViewController.h"

@interface StoreReviewsController : PullToRefreshViewController {
    
    AppStore* store;
    IBOutlet UIView* sectionHeader;
    IBOutlet UILabel* sectionHeaderLabel;
    IBOutlet UIImageView* AppIconImageView;
    IBOutlet UIImageView* StoreIconImageView;    
    IBOutlet UILabel* appNameLabel;
    IBOutlet UILabel* storeNameLabel;
    IBOutlet UIImageView* star1;
    IBOutlet UIImageView* star2;
    IBOutlet UIImageView* star3;
    IBOutlet UIImageView* star4;
    IBOutlet UIImageView* star5;

    NSFetchedResultsController *fetchedResultsController;    
}

@property (nonatomic, retain) AppStore* store;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil store:(AppStore*)_store;

- (IBAction) markAllAsReaded:(id)sender;

@end

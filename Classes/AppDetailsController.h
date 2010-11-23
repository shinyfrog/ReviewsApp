//
//  AppDetailsController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "models.h"
#import "PullToRefreshViewController.h"

@interface AppDetailsController : PullToRefreshViewController <UIActionSheetDelegate> {
    
    App* application;
    IBOutlet UIView* sectionHeader;
    IBOutlet UILabel* sectionHeaderLabel;
    IBOutlet UIImageView* AppIconImageView;
    IBOutlet UILabel* appNameLabel;

    NSFetchedResultsController *fetchedResultsController;

    IBOutlet UIImageView* star1;
    IBOutlet UIImageView* star2;
    IBOutlet UIImageView* star3;
    IBOutlet UIImageView* star4;
    IBOutlet UIImageView* star5;

}

@property (nonatomic, retain) App* application;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil application:(App*)_app;

- (IBAction) editStores;

@end

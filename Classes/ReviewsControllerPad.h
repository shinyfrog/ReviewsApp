//
//  ReviewsControllerPad.h
//  reviewApp
//
//  Created by Danilo Bonardi on 16/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PullToRefreshTableViewController.h"
#import "models.h"

@interface ReviewsControllerPad : PullToRefreshTableViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {

@private
    NSFetchedResultsController *fetchedResultsController_;

    AppStore* appStore;
    App* app;
    
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)loadAllReviews;

- (void)loadAllReviewsForApp:(App*)_app;

- (void)loadAllReviewsForAppStore:(AppStore*)_appStore;

@end

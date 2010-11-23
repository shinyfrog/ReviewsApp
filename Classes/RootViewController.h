//
//  RootViewController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 20/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PullToRefreshViewController.h"


@interface RootViewController : PullToRefreshViewController <UITableViewDelegate, UITableViewDataSource> {

@private
    NSFetchedResultsController *fetchedResultsController_;

}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

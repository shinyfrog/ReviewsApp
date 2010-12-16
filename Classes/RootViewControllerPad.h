//
//  RootViewControllerPad.h
//  reviewApp
//
//  Created by Danilo Bonardi on 14/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "PullToRefreshTableViewController.h"

@interface RootViewControllerPad : PullToRefreshTableViewController <UITableViewDelegate, UITableViewDataSource> {
    
@private
    NSFetchedResultsController *fetchedResultsController_;

    //IBOutlet UITableView* tableView;    
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

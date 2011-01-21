//
//  PullToRefreshTableViewController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 15/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EGORefreshTableHeaderView;
@interface PullToRefreshTableViewController : UITableViewController {

	EGORefreshTableHeaderView *refreshHeaderView;
    
	//  Reloading should really be your tableviews model class
	//  Putting it here for demo purposes 
	BOOL _reloading;
    
}

@property(assign,getter=isReloading) BOOL reloading;

- (void)setupRefreshHeaderView;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)dataSourceDidFinishLoadingNewData;

@end

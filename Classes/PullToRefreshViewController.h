//
//  PullToRefreshView.h
//  reviewApp
//
//  Created by Danilo Bonardi on 01/11/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EGORefreshTableHeaderView;
@interface PullToRefreshViewController : UIViewController {
	EGORefreshTableHeaderView *refreshHeaderView;

	//  Reloading should really be your tableviews model class
	//  Putting it here for demo purposes 
	BOOL _reloading;
    
    IBOutlet UITableView* tableView;

}

@property(assign,getter=isReloading) BOOL reloading;
@property(nonatomic, retain) IBOutlet UITableView* tableView;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)dataSourceDidFinishLoadingNewData;

@end

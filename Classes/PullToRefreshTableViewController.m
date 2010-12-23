//
//  PullToRefreshTableViewController.m
//  reviewApp
//
//  Created by Danilo Bonardi on 15/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "PullToRefreshTableViewController.h"
#import "EGORefreshTableHeaderView.h"

@class EGORefreshTableHeaderView;
@implementation PullToRefreshTableViewController

@synthesize reloading=_reloading;

- (void)viewDidLoad {
    [super viewDidLoad];
    
	if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.bounds.size.height, 320.0f, self.view.bounds.size.height)];
		[self.view addSubview:refreshHeaderView];
		((UITableView*)self.view).showsVerticalScrollIndicator = YES;
		[refreshHeaderView release];
	}
}


- (void)reloadTableViewDataSource {
}

- (void)doneLoadingTableViewData {
    [self dataSourceDidFinishLoadingNewData];    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	

    if (![refreshHeaderView isKindOfClass:[EGORefreshTableHeaderView class]]) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.bounds.size.height, 320.0f, self.view.bounds.size.height)];
		[self.view addSubview:refreshHeaderView];
		((UITableView*)self.view).showsVerticalScrollIndicator = YES;
		[refreshHeaderView release];
    }

	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.contentOffset.y <= - 65.0f && !_reloading) {
        _reloading = YES;
        [self reloadTableViewDataSource];
        [refreshHeaderView setState:EGOOPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        ((UITableView*)self.view).contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
	}
}

- (void)dataSourceDidFinishLoadingNewData{
	
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[((UITableView*)self.view) setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
}

@end

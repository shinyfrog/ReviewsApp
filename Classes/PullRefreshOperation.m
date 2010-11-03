//
//  PullRefreshOperation.m
//  reviewApp
//
//  Created by Danilo Bonardi on 01/11/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "PullRefreshOperation.h"
#import "reviewAppAppDelegate.h"

@implementation PullRefreshOperation

@synthesize father;

- (void)main {
    
    reviewAppAppDelegate* app = [[UIApplication sharedApplication] delegate];
    if ([app.pullToRefreshQueue operationCount] > 1) {
        [father performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];        
    }
    
    [father performSelector:@selector(syncTask)];

}

@end

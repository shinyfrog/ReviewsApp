//
//  PullRefreshOperation.m
//  reviewApp
//
//  Created by Danilo Bonardi on 01/11/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "PullRefreshOperation.h"


@implementation PullRefreshOperation

@synthesize father;

- (void)main {
    [father performSelector:@selector(syncTask)];

}

@end

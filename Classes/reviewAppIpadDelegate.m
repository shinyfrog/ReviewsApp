//
//  reviewAppIpadDelegate.m
//  reviewApp
//
//  Created by Danilo Bonardi on 14/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "reviewAppIpadDelegate.h"
#import "SearchAppViewControllerPad.h"
#import "RootViewControllerPad.h"
#import "ReviewsManager.h"

@implementation reviewAppIpadDelegate

@synthesize splitView, leftNav, rightNav, reviewsController;

#pragma mark -
#pragma mark Application lifecycle



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    application.statusBarStyle = UIStatusBarStyleBlackOpaque;

    splitView = [[TOSplitViewController alloc] initWithNibName:@"SplitView" bundle:nil panes:[NSArray  arrayWithObjects:leftNav,rightNav, nil]];        
    
    // Add the navigation controller's view to the window and display.
    [window addSubview:splitView.view];
    [window makeKeyAndVisible];

    window.backgroundColor = [UIColor blackColor];

    self.pullToRefreshQueue = [[[NSOperationQueue alloc] init] autorelease];
    [self.pullToRefreshQueue setMaxConcurrentOperationCount:1];    

    self.reviewsController = [[[ReviewsControllerPad alloc] initWithNibName:@"ReviewsControllerPad" bundle:nil] autorelease];
    [self.rightNav pushViewController:reviewsController animated:NO];

    RootViewControllerPad* root = [[[RootViewControllerPad alloc] initWithNibName:@"RootViewControllerPad" bundle:nil] autorelease];
    [self.leftNav pushViewController:root animated:NO];

    [self.leftNav.view addSubview:tableShadow];
    tableShadow.frame = CGRectMake(0, 44, 320, 5);

    return YES;
}

- (void)syncTask {
    
    @try {
        
        [ReviewsManager syncAllApps];
        
        [self performSelectorOnMainThread:@selector(endSyncMainThread) withObject:nil waitUntilDone:YES];

    } @catch (NSException * e) {
        SFLog(@"%@", [e description]);
    }

}

- (void) endSyncMainThread {
    UINavigationController* nav = (UINavigationController*)[self.splitView.viewControllers objectAtIndex:0];
    RootViewControllerPad* aViewController = (RootViewControllerPad*)nav.topViewController;
    [aViewController viewWillAppear:YES];    
}

@end

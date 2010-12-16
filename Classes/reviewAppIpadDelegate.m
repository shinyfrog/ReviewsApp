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
#import "ReviewsControllerPad.h"

@implementation reviewAppIpadDelegate

@synthesize spliView, leftNav, rightNav;

#pragma mark -
#pragma mark Application lifecycle



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    application.statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    // Add the navigation controller's view to the window and display.

    [window addSubview:spliView.view];
    [window makeKeyAndVisible];

    window.backgroundColor = [UIColor blackColor];

    [spliView toggleMasterView:nil];

    self.pullToRefreshQueue = [[[NSOperationQueue alloc] init] autorelease];
    [self.pullToRefreshQueue setMaxConcurrentOperationCount:1];    

    ReviewsControllerPad* foo = [[ReviewsControllerPad alloc] initWithNibName:@"ReviewsControllerPad" bundle:nil];
    [navigationController pushViewController:foo animated:NO];
    
    return YES;
}

- (void)syncTask {
    
    @try {
        
        [ReviewsManager syncAllApps];
        
        UINavigationController* nav = (UINavigationController*)[self.spliView.viewControllers objectAtIndex:0];
        RootViewControllerPad* aViewController = (RootViewControllerPad*)nav.topViewController;
        [aViewController viewWillAppear:YES];

    } @catch (NSException * e) {
        SFLog(@"%@", [e description]);
    }

}

@end

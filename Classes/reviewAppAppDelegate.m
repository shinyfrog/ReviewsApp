//
//  reviewAppAppDelegate.m
//  reviewApp
//
//  Created by Danilo Bonardi on 20/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "reviewAppAppDelegate.h"
#import "RootViewController.h"
#import "ReviewsManager.h"
#import "RootViewController.h"
#import "PullRefreshOperation.h"

@implementation reviewAppAppDelegate

@synthesize window, navigationController, managedObjectContext, managedObjectModel, persistentStoreCoordinator, pullToRefreshQueue;

#pragma mark -
#pragma mark Application lifecycle

- (void)awakeFromNib {    

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    application.statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    // Add the navigation controller's view to the window and display.
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    
    window.backgroundColor = [UIColor blackColor];
    
    self.pullToRefreshQueue = [[[NSOperationQueue alloc] init] autorelease];
    [self.pullToRefreshQueue setMaxConcurrentOperationCount:1];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSDate* lastSync = [ud objectForKey:@"lastSync"];
    NSDate *now      = [NSDate date];
    
    if (lastSync == nil || [now timeIntervalSinceDate:lastSync] >= 3600) {

        PullRefreshOperation* pro = [[[PullRefreshOperation alloc] init] autorelease];
        pro.father = self;
        [self.pullToRefreshQueue addOperation:pro];

    }
    

}

- (void)syncTask {
    
    @try {

        [ReviewsManager syncAllApps];
        RootViewController* aviewController = (RootViewController*)self.navigationController.topViewController;
        aviewController.fetchedResultsController = nil;
        [aviewController.tableView reloadData];

    } @catch (NSException * e) {
        NSLog(@"%@", [e description]);
    }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Core Data stack

- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) { return managedObjectModel; }

    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];

    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) { return persistentStoreCoordinator; }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"ReviewApp.sqlite"]];
	
	NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"%@", [error description]);
    }

    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
}


- (void)dealloc {
    
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];

    [navigationController release];
    [window release];
    [super dealloc];
}


@end


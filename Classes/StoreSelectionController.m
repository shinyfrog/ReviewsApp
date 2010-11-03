//
//  StoreSelectionController.m
//  reviewApp
//
//  Created by Danilo Bonardi on 25/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "StoreSelectionController.h"
#import "reviewAppAppDelegate.h"
#import "ReviewsManager.h"
#import "UINavigationBar+BackgroundImage.h"
#import "StoreCell.h"
#import "RootViewController.h"
#import "AppDetailsController.h"

@implementation AvailableStore

@synthesize name, storeId, languageCode;

+ (AvailableStore*) makeAvailableStoreWithId:(NSString*)storeId name:(NSString*)storeName languageCode:(NSString*)lcode{
    
    AvailableStore* astore = [[[AvailableStore alloc] init] autorelease];
    astore.name = storeName;
    astore.storeId = storeId;
    astore.languageCode = lcode;
    return astore;
    
}

- (Store*) toStore {
    reviewAppAppDelegate* app    = [[UIApplication sharedApplication] delegate];

    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:@"Store" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"storeID = %@", self.storeId];
    [fetchRequest setPredicate:predicate];
    NSError* error=nil;
    NSArray *stores = [app.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    Store* store = nil;
    
    if ([stores count] == 0) {
        store = [Store insertInManagedObjectContext:app.managedObjectContext];
    } else {
        store = [stores objectAtIndex:0];
    }
    
    store.storeName = self.name;
    store.storeID = self.storeId;
    store.countryCode = self.languageCode;

    return store;
}

@end

@implementation StoreSelectionController

@synthesize availableStores, selectedStores, appId, waitingDialog, tableView, appLink;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil father:(id)_father appId:(NSString*)appid {
    
    if (![super initWithNibName:nibName bundle:bundleOrNil]) {
        return nil;
    }
    
    father = _father;
    
    NSMutableArray* stores = [NSMutableArray arrayWithCapacity:100];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143441" name:@"United States" languageCode:@"us"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143444" name:@"United Kingdom" languageCode:@"uk"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143442" name:@"France" languageCode:@"fr"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143455" name:@"Canada" languageCode:@"ca"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143443" name:@"Deutschland" languageCode:@"de"]];    
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143460" name:@"Australia" languageCode:@"au"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143462" name:@"Japan" languageCode:@"jp"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143450" name:@"Italia" languageCode:@"it"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143465" name:@"China" languageCode:@"cn"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143452" name:@"Nederlands" languageCode:@"nl"]];
    
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143505" name:@"Argentina" languageCode:@"ar"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143446" name:@"Belgium" languageCode:@"be"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143503" name:@"Brazil" languageCode:@"br"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143483" name:@"Chile" languageCode:@"cl"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143501" name:@"Colombia" languageCode:@"co"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143495" name:@"Costa Rica" languageCode:@"cr"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143494" name:@"Croatia" languageCode:@"hr"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143489" name:@"Czech Republic" languageCode:@"cs"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143458" name:@"Denmark" languageCode:@"dk"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143508" name:@"Dominican Republic" languageCode:@"do"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143509" name:@"Ecuador" languageCode:@"ec"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143516" name:@"Egypt" languageCode:@"eg"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143506" name:@"El Salvador" languageCode:@"sv"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143454" name:@"Espana" languageCode:@"es"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143518" name:@"Estonia" languageCode:@"ee"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143447" name:@"Finland" languageCode:@"fi"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143448" name:@"Greece" languageCode:@"gr"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143504" name:@"Guatemala" languageCode:@"gt"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143510" name:@"Honduras" languageCode:@"hn"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143463" name:@"Hong Kong" languageCode:@"hk"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143482" name:@"Hungary" languageCode:@"hu"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143467" name:@"India" languageCode:@"in"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143476" name:@"Indonesia" languageCode:@"id"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143449" name:@"Ireland" languageCode:@"ie"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143491" name:@"Israel" languageCode:@"il"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143517" name:@"Kazakhstan" languageCode:@"kz"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143466" name:@"Korea" languageCode:@"kp"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143493" name:@"Kuwait" languageCode:@"kw"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143519" name:@"Latvia" languageCode:@"lv"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143497" name:@"Lebanon" languageCode:@"lb"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143520" name:@"Lithuania" languageCode:@"lt"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143451" name:@"Luxembourg" languageCode:@"lu"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143515" name:@"Macau" languageCode:@"mo"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143521" name:@"Malta" languageCode:@"mt"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143473" name:@"Malaysia" languageCode:@"my"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143468" name:@"Mexico" languageCode:@"mx"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143523" name:@"Moldova" languageCode:@"md"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143461" name:@"New Zealand" languageCode:@"nz"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143457" name:@"Norway" languageCode:@"no"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143512" name:@"Nicaragua" languageCode:@"ni"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143445" name:@"Osterreich" languageCode:@"at"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143477" name:@"Pakistan" languageCode:@"pk"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143485" name:@"Panama" languageCode:@"pa"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143513" name:@"Paraguay" languageCode:@"py"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143507" name:@"Peru" languageCode:@"pe"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143474" name:@"Phillipines" languageCode:@"ph"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143478" name:@"Poland" languageCode:@"pl"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143453" name:@"Portugal" languageCode:@"pt"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143498" name:@"Qatar" languageCode:@"qa"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143487" name:@"Romania" languageCode:@"ro"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143469" name:@"Russia" languageCode:@"ru"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143479" name:@"Saudi Arabia" languageCode:@"sa"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143459" name:@"Schweiz/Suisse" languageCode:@"ch"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143464" name:@"Singapore" languageCode:@"sg"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143496" name:@"Slovakia" languageCode:@"sk"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143499" name:@"Slovenia" languageCode:@"si"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143472" name:@"South Africa" languageCode:@"za"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143486" name:@"Sri Lanka" languageCode:@"lk"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143456" name:@"Sweden" languageCode:@"se"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143470" name:@"Taiwan" languageCode:@"tw"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143475" name:@"Thailand" languageCode:@"th"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143480" name:@"Turkey" languageCode:@"tr"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143481" name:@"United Arab Emirates" languageCode:@"ae"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143514" name:@"Uruguay" languageCode:@"uy"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143502" name:@"Venezuela" languageCode:@"ve"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143471" name:@"Vietnam" languageCode:@"vn"]];
    [stores addObject:[AvailableStore makeAvailableStoreWithId:@"143511" name:@"Jamaica" languageCode:@"jm"]];

    self.availableStores = stores;
    
    self.selectedStores = [NSMutableArray array];
    self.appId = appid;
    self.appLink = @"";
    
    reviewAppAppDelegate* app    = [[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:@"App" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"appId = %@", self.appId];
    [fetchRequest setPredicate:predicate];
    NSError* error=nil;
    NSArray *apps = [app.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    //Edit mode set selected stores
    if ([apps count] != 0) {
        App* app = [apps objectAtIndex:0];
        for (AppStore* as in app.stores) {
            for (AvailableStore* avs in self.availableStores) {
                if ([avs.storeId isEqualToString:as.store.storeID]) {
                    [self.selectedStores addObject:avs];
                }
            }
        }
    }
    
    return self;
}

- (void) viewDidLoad {
    
    self.title = @"Select the stores";
    
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_back.png"] withBackgroundTint:[UIColor grayColor]];    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.451 green:0.518 blue:0.616 alpha:1.000]];    

	UIImageView *tableBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_back.png"]] autorelease];
	[self.tableView setBackgroundView:tableBg];    
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButtonArrow.png"] 
                                                                    style:self.navigationItem.backBarButtonItem.style
                                                                   target:self.navigationItem.backBarButtonItem.target 
                                                                   action:self.navigationItem.backBarButtonItem.action] autorelease];
    self.navigationItem.backBarButtonItem = backButton;

}

- (void) viewDidAppear:(BOOL)animated {
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setTintColor:kSCNavigationBarTintColor];
    
    UIImageView *imageView = (UIImageView *)[[navBar viewWithTag:kSCNavigationBarBackgroundImageTag] retain];
    [imageView removeFromSuperview];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addStoresAction)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    if ([father isKindOfClass:[AppDetailsController class]]) {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeAction)];    
        self.navigationItem.leftBarButtonItem = cancelButton;
    }    
    
    [navBar insertSubview:imageView atIndex:0];    

}

- (IBAction) closeAction {
    [father dismissModalViewControllerAnimated:YES];   
}

- (IBAction) addStoresAction {
    self.waitingDialog = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [self.view.window addSubview:self.waitingDialog];
    self.waitingDialog.delegate  = self;
    self.waitingDialog.labelText = @"Adding Stores";
    [self.waitingDialog showWhileExecuting:@selector(addStores) onTarget:self withObject:nil animated:YES];
}

- (void) addStores {

    if ([selectedStores count] == 0) { return; }

    reviewAppAppDelegate* app    = [[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:@"App" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"appId = %@", self.appId];
    [fetchRequest setPredicate:predicate];
    NSError* error=nil;
    NSArray *apps = [app.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    App* newApp = nil;
    
    if ([apps count] == 0) {
        newApp = [App insertInManagedObjectContext:app.managedObjectContext];
    } else {
        newApp = [apps objectAtIndex:0];
    }

    newApp.appId = self.appId;
    newApp.link = self.appLink;
    newApp.orderValue = 1;

    //Add Stores
    NSMutableDictionary* dicAppStores = [NSMutableDictionary dictionary];
    NSMutableDictionary* dicSelectedStores = [NSMutableDictionary dictionary];
    
    BOOL firstSync = NO;
    
    for (AppStore* as in newApp.stores) { [dicAppStores setObject:as forKey:as.store.storeID]; }
    for (AvailableStore* avs in selectedStores) { [dicSelectedStores setObject:avs forKey:avs.storeId]; }

    
    if ([father isKindOfClass:[RootViewController class]]) { firstSync = YES; }
    
    //Add news stores
    for (AvailableStore* avs in selectedStores) {
        if ([dicAppStores objectForKey:avs.storeId] == nil) {
            Store* store = [avs toStore];
            AppStore* appStore = [AppStore insertInManagedObjectContext:app.managedObjectContext];
            appStore.app = newApp;
            appStore.store = store;
        }
    }

    //Delete Unselected Stores
    for (AppStore* as in newApp.stores) {
        if ([dicSelectedStores objectForKey:as.store.storeID] == nil) {
            [app.managedObjectContext deleteObject:as];
        }
    }

    //sync
    
    @try {
        [ReviewsManager newAppSync:newApp];
    } @catch (NSException * e) {
        
        NSLog(@"%@", [e description]);
        
        if (firstSync) {
            
            for (AppStore* as in newApp.stores) {
                [app.managedObjectContext deleteObject:as];
            }
            
            [app.managedObjectContext deleteObject:newApp];
            
            
            UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Unable to add the application" 
                                                           message:@"check the application ID or try again later"
                                                          delegate:self 
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil] autorelease];
            [alert show];
        } else {
            UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Unable to update the reviews" 
                                                            message:@"Please try to sync later"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil] autorelease];
            [alert show];
        }
    }
    
    [father dismissModalViewControllerAnimated:YES];

}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView { return 1; }

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section { return [self.availableStores count]; }

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    StoreCell *cell = (StoreCell*)[_tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
    if (cell == nil) {
        UIViewController* vc = [[[UIViewController alloc] initWithNibName:@"StoreCell" bundle:nil] autorelease];
        cell = (StoreCell*)vc.view;
    }

    AvailableStore *store = [self.availableStores objectAtIndex:indexPath.row];

    if ([selectedStores indexOfObject:store] != NSNotFound) {
        cell.imageView.image = [UIImage imageNamed:@"search_cell_selected.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"search_cell.png"];
    }

    cell.storeNameLabel.text = store.name;
    cell.storeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@30.png", store.languageCode]];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AvailableStore *store = [self.availableStores objectAtIndex:indexPath.row];
    
    if ([selectedStores indexOfObject:store] == NSNotFound) {
        [selectedStores addObject:store];
    } else {
        [selectedStores removeObject:store];
    }

    [_tableView reloadData];
}

- (void)hudWasHidden {
}


@end

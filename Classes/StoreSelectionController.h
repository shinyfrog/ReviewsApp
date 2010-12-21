//
//  StoreSelectionController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 25/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "models.h"
#import "MBProgressHUD.h"

@interface AvailableStore : NSObject {
    NSString* name;
    NSString* storeId;
    NSString* languageCode;    
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* storeId;
@property (nonatomic, retain) NSString* languageCode;

+ (AvailableStore*) makeAvailableStoreWithId:(NSString*)storeId name:(NSString*)storeName languageCode:(NSString*)lcode;

- (Store*) toStore;

@end

@interface StoreSelectionController : UIViewController <MBProgressHUDDelegate> {

    IBOutlet UITableView* tableView;
    NSArray* availableStores;
    NSMutableArray* selectedStores;
    id father;
    NSString* appId;
    MBProgressHUD* waitingDialog;
    NSString* appLink;    
    
}

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil father:(id)_father appId:(NSString*)appid;

- (void) addStoresEnded;

@property (nonatomic, retain) NSArray* availableStores;
@property (nonatomic, retain) NSMutableArray* selectedStores;
@property (nonatomic, retain) NSString* appId;
@property (nonatomic, retain) NSString* appLink;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) MBProgressHUD* waitingDialog;

@end


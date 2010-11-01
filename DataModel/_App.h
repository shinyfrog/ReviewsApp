// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to App.h instead.

#import <CoreData/CoreData.h>


@class AppStore;







@interface AppID : NSManagedObjectID {}
@end

@interface _App : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AppID*)objectID;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *appId;

//- (BOOL)validateAppId:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *link;

//- (BOOL)validateLink:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *order;

@property short orderValue;
- (short)orderValue;
- (void)setOrderValue:(short)value_;

//- (BOOL)validateOrder:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* stores;
- (NSMutableSet*)storesSet;



@end

@interface _App (CoreDataGeneratedAccessors)

- (void)addStores:(NSSet*)value_;
- (void)removeStores:(NSSet*)value_;
- (void)addStoresObject:(AppStore*)value_;
- (void)removeStoresObject:(AppStore*)value_;

@end

@interface _App (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;


- (NSString*)primitiveAppId;
- (void)setPrimitiveAppId:(NSString*)value;


- (NSString*)primitiveLink;
- (void)setPrimitiveLink:(NSString*)value;


- (NSNumber*)primitiveOrder;
- (void)setPrimitiveOrder:(NSNumber*)value;

- (short)primitiveOrderValue;
- (void)setPrimitiveOrderValue:(short)value_;


- (NSString*)primitiveImage;
- (void)setPrimitiveImage:(NSString*)value;




- (NSMutableSet*)primitiveStores;
- (void)setPrimitiveStores:(NSMutableSet*)value;


@end

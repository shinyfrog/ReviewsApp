// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Store.h instead.

#import <CoreData/CoreData.h>


@class AppStore;





@interface StoreID : NSManagedObjectID {}
@end

@interface _Store : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (StoreID*)objectID;



@property (nonatomic, retain) NSString *countryCode;

//- (BOOL)validateCountryCode:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *storeID;

//- (BOOL)validateStoreID:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *storeName;

//- (BOOL)validateStoreName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* data;
- (NSMutableSet*)dataSet;



@end

@interface _Store (CoreDataGeneratedAccessors)

- (void)addData:(NSSet*)value_;
- (void)removeData:(NSSet*)value_;
- (void)addDataObject:(AppStore*)value_;
- (void)removeDataObject:(AppStore*)value_;

@end

@interface _Store (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCountryCode;
- (void)setPrimitiveCountryCode:(NSString*)value;


- (NSString*)primitiveStoreID;
- (void)setPrimitiveStoreID:(NSString*)value;


- (NSString*)primitiveStoreName;
- (void)setPrimitiveStoreName:(NSString*)value;




- (NSMutableSet*)primitiveData;
- (void)setPrimitiveData:(NSMutableSet*)value;


@end

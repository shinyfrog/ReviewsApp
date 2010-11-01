// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AppStore.h instead.

#import <CoreData/CoreData.h>


@class App;
@class Store;
@class Review;




@interface AppStoreID : NSManagedObjectID {}
@end

@interface _AppStore : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AppStoreID*)objectID;



@property (nonatomic, retain) NSNumber *stars;

@property short starsValue;
- (short)starsValue;
- (void)setStarsValue:(short)value_;

//- (BOOL)validateStars:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *insertionDate;

//- (BOOL)validateInsertionDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) App* app;
//- (BOOL)validateApp:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Store* store;
//- (BOOL)validateStore:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* reviews;
- (NSMutableSet*)reviewsSet;



@end

@interface _AppStore (CoreDataGeneratedAccessors)

- (void)addReviews:(NSSet*)value_;
- (void)removeReviews:(NSSet*)value_;
- (void)addReviewsObject:(Review*)value_;
- (void)removeReviewsObject:(Review*)value_;

@end

@interface _AppStore (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveStars;
- (void)setPrimitiveStars:(NSNumber*)value;

- (short)primitiveStarsValue;
- (void)setPrimitiveStarsValue:(short)value_;


- (NSDate*)primitiveInsertionDate;
- (void)setPrimitiveInsertionDate:(NSDate*)value;




- (App*)primitiveApp;
- (void)setPrimitiveApp:(App*)value;



- (Store*)primitiveStore;
- (void)setPrimitiveStore:(Store*)value;



- (NSMutableSet*)primitiveReviews;
- (void)setPrimitiveReviews:(NSMutableSet*)value;


@end

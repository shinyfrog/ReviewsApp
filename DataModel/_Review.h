// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Review.h instead.

#import <CoreData/CoreData.h>


@class AppStore;












@interface ReviewID : NSManagedObjectID {}
@end

@interface _Review : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ReviewID*)objectID;



@property (nonatomic, retain) NSNumber *storeOrder;

@property short storeOrderValue;
- (short)storeOrderValue;
- (void)setStoreOrderValue:(short)value_;

//- (BOOL)validateStoreOrder:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *message;

//- (BOOL)validateMessage:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *stars;

@property short starsValue;
- (short)starsValue;
- (void)setStarsValue:(short)value_;

//- (BOOL)validateStars:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *insertionDate;

//- (BOOL)validateInsertionDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *version;

//- (BOOL)validateVersion:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *viewed;

@property BOOL viewedValue;
- (BOOL)viewedValue;
- (void)setViewedValue:(BOOL)value_;

//- (BOOL)validateViewed:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *reviewId;

//- (BOOL)validateReviewId:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) AppStore* appstore;
//- (BOOL)validateAppstore:(id*)value_ error:(NSError**)error_;



@end

@interface _Review (CoreDataGeneratedAccessors)

@end

@interface _Review (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveStoreOrder;
- (void)setPrimitiveStoreOrder:(NSNumber*)value;

- (short)primitiveStoreOrderValue;
- (void)setPrimitiveStoreOrderValue:(short)value_;


- (NSString*)primitiveMessage;
- (void)setPrimitiveMessage:(NSString*)value;


- (NSNumber*)primitiveStars;
- (void)setPrimitiveStars:(NSNumber*)value;

- (short)primitiveStarsValue;
- (void)setPrimitiveStarsValue:(short)value_;


- (NSString*)primitiveUser;
- (void)setPrimitiveUser:(NSString*)value;


- (NSDate*)primitiveInsertionDate;
- (void)setPrimitiveInsertionDate:(NSDate*)value;


- (NSString*)primitiveDate;
- (void)setPrimitiveDate:(NSString*)value;


- (NSString*)primitiveVersion;
- (void)setPrimitiveVersion:(NSString*)value;


- (NSNumber*)primitiveViewed;
- (void)setPrimitiveViewed:(NSNumber*)value;

- (BOOL)primitiveViewedValue;
- (void)setPrimitiveViewedValue:(BOOL)value_;


- (NSString*)primitiveReviewId;
- (void)setPrimitiveReviewId:(NSString*)value;


- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (AppStore*)primitiveAppstore;
- (void)setPrimitiveAppstore:(AppStore*)value;


@end

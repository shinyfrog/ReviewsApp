// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Review.m instead.

#import "_Review.h"

@implementation ReviewID
@end

@implementation _Review

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Review" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Review";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Review" inManagedObjectContext:moc_];
}

- (ReviewID*)objectID {
	return (ReviewID*)[super objectID];
}




@dynamic storeOrder;



- (short)storeOrderValue {
	NSNumber *result = [self storeOrder];
	return [result shortValue];
}

- (void)setStoreOrderValue:(short)value_ {
	[self setStoreOrder:[NSNumber numberWithShort:value_]];
}

- (short)primitiveStoreOrderValue {
	NSNumber *result = [self primitiveStoreOrder];
	return [result shortValue];
}

- (void)setPrimitiveStoreOrderValue:(short)value_ {
	[self setPrimitiveStoreOrder:[NSNumber numberWithShort:value_]];
}





@dynamic message;






@dynamic stars;



- (short)starsValue {
	NSNumber *result = [self stars];
	return [result shortValue];
}

- (void)setStarsValue:(short)value_ {
	[self setStars:[NSNumber numberWithShort:value_]];
}

- (short)primitiveStarsValue {
	NSNumber *result = [self primitiveStars];
	return [result shortValue];
}

- (void)setPrimitiveStarsValue:(short)value_ {
	[self setPrimitiveStars:[NSNumber numberWithShort:value_]];
}





@dynamic user;






@dynamic insertionDate;






@dynamic date;






@dynamic version;






@dynamic viewed;



- (BOOL)viewedValue {
	NSNumber *result = [self viewed];
	return [result boolValue];
}

- (void)setViewedValue:(BOOL)value_ {
	[self setViewed:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveViewedValue {
	NSNumber *result = [self primitiveViewed];
	return [result boolValue];
}

- (void)setPrimitiveViewedValue:(BOOL)value_ {
	[self setPrimitiveViewed:[NSNumber numberWithBool:value_]];
}





@dynamic reviewId;






@dynamic title;






@dynamic appstore;

	



@end

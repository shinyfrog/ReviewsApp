// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AppStore.m instead.

#import "_AppStore.h"

@implementation AppStoreID
@end

@implementation _AppStore

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AppStore" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AppStore";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AppStore" inManagedObjectContext:moc_];
}

- (AppStoreID*)objectID {
	return (AppStoreID*)[super objectID];
}




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





@dynamic insertionDate;






@dynamic app;

	

@dynamic store;

	

@dynamic reviews;

	
- (NSMutableSet*)reviewsSet {
	[self willAccessValueForKey:@"reviews"];
	NSMutableSet *result = [self mutableSetValueForKey:@"reviews"];
	[self didAccessValueForKey:@"reviews"];
	return result;
}
	



@end

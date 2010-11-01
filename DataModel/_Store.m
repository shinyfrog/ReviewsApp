// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Store.m instead.

#import "_Store.h"

@implementation StoreID
@end

@implementation _Store

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Store" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Store";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Store" inManagedObjectContext:moc_];
}

- (StoreID*)objectID {
	return (StoreID*)[super objectID];
}




@dynamic countryCode;






@dynamic storeID;






@dynamic storeName;






@dynamic data;

	
- (NSMutableSet*)dataSet {
	[self willAccessValueForKey:@"data"];
	NSMutableSet *result = [self mutableSetValueForKey:@"data"];
	[self didAccessValueForKey:@"data"];
	return result;
}
	



@end

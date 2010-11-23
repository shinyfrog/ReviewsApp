// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to App.m instead.

#import "_App.h"

@implementation AppID
@end

@implementation _App

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"App" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"App";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"App" inManagedObjectContext:moc_];
}

- (AppID*)objectID {
	return (AppID*)[super objectID];
}




@dynamic name;






@dynamic appId;






@dynamic link;






@dynamic order;



- (short)orderValue {
	NSNumber *result = [self order];
	return [result shortValue];
}

- (void)setOrderValue:(short)value_ {
	[self setOrder:[NSNumber numberWithShort:value_]];
}

- (short)primitiveOrderValue {
	NSNumber *result = [self primitiveOrder];
	return [result shortValue];
}

- (void)setPrimitiveOrderValue:(short)value_ {
	[self setPrimitiveOrder:[NSNumber numberWithShort:value_]];
}





@dynamic image;






@dynamic stores;

	
- (NSMutableSet*)storesSet {
	[self willAccessValueForKey:@"stores"];
	NSMutableSet *result = [self mutableSetValueForKey:@"stores"];
	[self didAccessValueForKey:@"stores"];
	return result;
}
	



@end

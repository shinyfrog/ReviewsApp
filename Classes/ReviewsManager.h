//
//  ReviewsManager.h
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "models.h"

@interface ReviewsManager : NSObject {

}

+ (void) getReviewsForAppStore:(AppStore*)as;

+ (void) addReviewWithTitle:(NSString*)title body:(NSString*)body user:(NSString*)user rating:(NSString*)rating 
                       date:(NSString*)date version:(NSString*)version storeOder:(int)storeOrder 
                   appStore:(AppStore*)as reviews:(NSDictionary*) reviews;

+ (void) syncAllApps;

+ (void) newAppSync:(App*)newApp;

+ (void) saveImageWithUrl:(NSString*)imageURL inApp:(App*)app;

- (void) addReviewThreadSafe:(NSDictionary*)dataDict;

@end

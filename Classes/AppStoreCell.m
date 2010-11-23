//
//  AppStoreCell.m
//  reviewApp
//
//  Created by Danilo Bonardi on 29/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "AppStoreCell.h"


@implementation AppStoreCell

@synthesize appStoreNameLabel, appStoreIcon, appStoreReviewsLabel, badge;

- (void) setStars:(NSNumber*)stars {

    NSArray* ivstars = [NSArray arrayWithObjects:star1, star2, star3, star4, star5, nil];
    
    for (UIImageView* ivstar in ivstars) {
        ivstar.image = [UIImage imageNamed:@"emptyStar.png"];
    }
    
    int i=0;

    for (; i<[stars intValue]; i++) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"fullStar.png"];
    }

    if (i < 5 && (i+1)-[stars floatValue] == 0.5) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"halfStar.png"];
    }

}

@end

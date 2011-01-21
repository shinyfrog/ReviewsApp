//
//  ReviewCellPad.m
//  reviewApp
//
//  Created by Danilo Bonardi on 20/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "ReviewCellPad.h"


@implementation ReviewCellPad

@synthesize reviewTitle, reviewComment, reviewCommentLabel, applicationIconImageView, coutryLabel, countryFlagImageView;
- (void) setStars:(NSNumber*)stars {
    NSArray* ivstars = [NSArray arrayWithObjects:star1, star2, star3, star4, star5, nil];
    
    for (UIImageView* ivstar in ivstars) {
        ivstar.image = [UIImage imageNamed:@"emptyStar.png"];
    }
    
    for (int i=0; i<[stars intValue]; i++) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"fullStar.png"];
    }
}

@end

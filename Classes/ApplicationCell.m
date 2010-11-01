//
//  ApplicationCellController.m
//  reviewApp
//
//  Created by Danilo Bonardi on 28/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "ApplicationCell.h"


@implementation ApplicationCell

@synthesize applicationNameLabel, applicationIconImageView, badge;

- (void) setStars:(float)stars {

    NSArray* ivstars = [NSArray arrayWithObjects:star1, star2, star3, star4, star5, nil];
    
    for (UIImageView* ivstar in ivstars) {
        ivstar.image = [UIImage imageNamed:@"emptyStar.png"];
    }
    
    int i=0;
    
    for (; i<stars; i++) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"fullStar.png"];
    }
    
    if (i < 5 && (i+1)-stars >= 0.5) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"halfStar.png"];
    }

}

@end

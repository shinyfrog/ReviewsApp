//
//  AppStoreCell.h
//  reviewApp
//
//  Created by Danilo Bonardi on 29/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFUIBadgeView.h"

@interface AppStoreCell : UITableViewCell {
    
    IBOutlet UILabel* appStoreNameLabel;
    IBOutlet UIImageView* appStoreIcon;
    IBOutlet UILabel* appStoreReviewsLabel;
    IBOutlet UIImageView* star1;
    IBOutlet UIImageView* star2;
    IBOutlet UIImageView* star3;
    IBOutlet UIImageView* star4;
    IBOutlet UIImageView* star5;
    IBOutlet SFUIBadgeView* badge;

}

@property (nonatomic, retain) IBOutlet UILabel* appStoreNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView* appStoreIcon;
@property (nonatomic, retain) IBOutlet UILabel* appStoreReviewsLabel;
@property (nonatomic, retain) IBOutlet SFUIBadgeView* badge;

- (void) setStars:(NSNumber*)stars;

@end

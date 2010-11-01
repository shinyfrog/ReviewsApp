//
//  ApplicationCellController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 28/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFUIBadgeView.h"

@interface ApplicationCell : UITableViewCell {

    IBOutlet UILabel* applicationNameLabel;
    IBOutlet UIImageView* applicationIconImageView;
    IBOutlet SFUIBadgeView* badge;

    IBOutlet UIImageView* star1;
    IBOutlet UIImageView* star2;
    IBOutlet UIImageView* star3;
    IBOutlet UIImageView* star4;
    IBOutlet UIImageView* star5;

}

@property (nonatomic, retain) IBOutlet UILabel* applicationNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView* applicationIconImageView;
@property (nonatomic, retain) IBOutlet SFUIBadgeView* badge;

- (void) setStars:(float)stars;

@end

//
//  ReviewCell.h
//  reviewApp
//
//  Created by Danilo Bonardi on 29/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ReviewCell : UITableViewCell {
    
    IBOutlet UILabel* reviewTitle;
    IBOutlet UIImageView* star1;
    IBOutlet UIImageView* star2;
    IBOutlet UIImageView* star3;
    IBOutlet UIImageView* star4;
    IBOutlet UIImageView* star5;

}

@property (nonatomic, retain) IBOutlet UILabel* reviewTitle;
@property (nonatomic, retain) IBOutlet UIImageView* star1;
@property (nonatomic, retain) IBOutlet UIImageView* star2;
@property (nonatomic, retain) IBOutlet UIImageView* star3;
@property (nonatomic, retain) IBOutlet UIImageView* star4;
@property (nonatomic, retain) IBOutlet UIImageView* star5;

- (void) setStars:(NSNumber*)stars;

@end

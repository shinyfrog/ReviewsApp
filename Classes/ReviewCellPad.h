//
//  ReviewCellPad.h
//  reviewApp
//
//  Created by Danilo Bonardi on 20/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ReviewCellPad : UITableViewCell {

    IBOutlet UILabel* reviewTitle;    
    IBOutlet UITextView* reviewComment;    
    IBOutlet UILabel *reviewCommentLabel;
    
	IBOutlet UIImageView* applicationIconImageView;
	
	IBOutlet UIImageView* star1;
    IBOutlet UIImageView* star2;
    IBOutlet UIImageView* star3;
    IBOutlet UIImageView* star4;
    IBOutlet UIImageView* star5;

	
	IBOutlet UILabel* coutryLabel;
    IBOutlet UIImageView* countryFlagImageView;

}

@property (nonatomic, retain) IBOutlet UILabel* reviewTitle;
@property (nonatomic, retain) IBOutlet UITextView* reviewComment;
@property (nonatomic, retain) IBOutlet UILabel *reviewCommentLabel;
@property (nonatomic, retain) IBOutlet UIImageView* applicationIconImageView;
@property (nonatomic, retain) IBOutlet UILabel* coutryLabel;
@property (nonatomic, retain) IBOutlet UIImageView* countryFlagImageView;

- (void) setStars:(NSNumber*)stars;

@end

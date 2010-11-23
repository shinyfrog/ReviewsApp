//
//  ReviewDetailsController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "models.h"
#import "MBProgressHUD.h"

@interface ReviewDetailsController : UIViewController <UIActionSheetDelegate, MBProgressHUDDelegate> {

    IBOutlet UITextView* textView;
    IBOutlet UITextView* textViewShadow;
    IBOutlet UILabel* reviewTitleLabel;
    IBOutlet UILabel* reviewCoutryLabel;
    IBOutlet UILabel* reviewAuthorLabel;
    IBOutlet UILabel* reviewVersionLabel;    
    IBOutlet UIImageView* countryFlagImageView;
    IBOutlet UIImageView* star1;
    IBOutlet UIImageView* star2;
    IBOutlet UIImageView* star3;
    IBOutlet UIImageView* star4;
    IBOutlet UIImageView* star5;
    Review* review;
    
    MBProgressHUD* waitingDialog;    
    
}

@property (nonatomic, retain) Review* review;
@property (nonatomic, retain) MBProgressHUD* waitingDialog;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil review:(Review*)_review;

@end

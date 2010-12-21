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
    
}

@property (nonatomic, retain) IBOutlet UILabel* reviewTitle;
@property (nonatomic, retain) IBOutlet UITextView* reviewComment;

@end

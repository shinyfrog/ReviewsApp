//
//  StoreCell.h
//  reviewApp
//
//  Created by Danilo Bonardi on 28/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StoreCell : UITableViewCell {

    IBOutlet UILabel* storeNameLabel;
    IBOutlet UIImageView* storeImageView;    
    
}

@property (nonatomic, retain) IBOutlet UILabel* storeNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView* storeImageView;

@end

//
//  PullRefreshOperation.h
//  reviewApp
//
//  Created by Danilo Bonardi on 01/11/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PullRefreshOperation : NSOperation {
    id father;
}

@property (nonatomic, retain) id father;

@end

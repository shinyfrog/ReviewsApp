//
//  SearchOperation.h
//  reviewApp
//
//  Created by Danilo Bonardi on 28/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchOperation : NSOperation {
    NSObject* father;
    NSString* searchString;
}

@property (nonatomic,retain) NSObject* father;
@property (nonatomic,retain) NSString* searchString;

@end

//
//  UIImage+pngThumb.h
//  iPase
//
//  Created by Danilo Bonardi on 30/09/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (pngThumb)

- (NSData*) pngThumbWithMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight;

@end

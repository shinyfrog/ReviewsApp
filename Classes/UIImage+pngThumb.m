//
//  UIImage+pngThumb.m
//  iPase
//
//  Created by Danilo Bonardi on 30/09/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "UIImage+pngThumb.h"


@implementation UIImage (pngThumb)

- (NSData*) pngThumbWithMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight {
    
	CGSize size = self.size;
	CGFloat ratio = 0;    
    
	if (size.width > size.height) { ratio = maxWidth / size.width; } 
    else                          { ratio = maxHeight / size.height; }

	CGRect rect1 = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    
	UIGraphicsBeginImageContext(rect1.size);
	[self drawInRect:rect1];
	UIImage*thumb1 = UIGraphicsGetImageFromCurrentImageContext();
    NSData *thumbdataForPNGFile1 = UIImagePNGRepresentation(thumb1);
	UIGraphicsEndImageContext();

    return thumbdataForPNGFile1;
}

@end

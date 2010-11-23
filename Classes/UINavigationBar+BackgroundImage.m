//
//  UINavigationBar+BackgroundImage.m
//  WiMove
//
//  Created by Matteo Rattotti on 9/13/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "UINavigationBar+BackgroundImage.h"



@implementation UINavigationBar (BackgroundImage)

- (void) setBackgroundImage: (UIImage *) image withBackgroundTint: (UIColor *) tint {
    [self setTintColor:tint];
    
    UIImageView *imageView = (UIImageView *)[self viewWithTag:kSCNavigationBarBackgroundImageTag];
    if (imageView == nil)
    {
        imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setTag:kSCNavigationBarBackgroundImageTag];
        [self insertSubview:imageView atIndex:0];
        [imageView release];
    }
    
}

@end

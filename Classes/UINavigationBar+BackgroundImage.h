//
//  UINavigationBar+BackgroundImage.h
//  WiMove
//
//  Created by Matteo Rattotti on 9/13/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kSCNavigationBarBackgroundImageTag 6183746
#define kSCNavigationBarTintColor [UIColor colorWithRed:0.451 green:0.518 blue:0.616 alpha:1.000]

@interface UINavigationBar (BackgroundImage)

- (void) setBackgroundImage: (UIImage *) image withBackgroundTint: (UIColor *) tint;

@end

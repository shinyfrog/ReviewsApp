//
//  SFUIBadgeView.h
//  badgeApp
//
//  Created by Matteo Rattotti on 10/29/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface SFUIBadgeView : UIView {
	UILabel *badgeLabel;
	CAGradientLayer *gradientLayer;
}

@property (nonatomic, retain) UILabel *badgeLabel;
@property (nonatomic, retain) CAGradientLayer *gradientLayer;

- (void) setBadgeText: (NSString *) text;
- (void) setBadgeValue: (int) value;

- (void) setupBadge;
- (void) setupLayers;
- (void) setupText;

- (CGFloat) badgeInset;
- (CGFloat) cornerRadiusForFrame: (CGRect) frame;
- (UIFont *) badgeFont;

@end

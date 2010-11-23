//
//  SFUIBadgeView.m
//  badgeApp
//
//  Created by Matteo Rattotti on 10/29/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "SFUIBadgeView.h"

@implementation SFUIBadgeView

@synthesize badgeLabel, gradientLayer;

- (void) awakeFromNib {
	[self setupBadge];

}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self setupBadge];
    }
    return self;
}

- (void) setBadgeValue:(int)value {
	[self setBadgeText:[NSString stringWithFormat:@"%d", value]];
}

- (void) setBadgeText: (NSString *) text {

	badgeLabel.text = text;

	int newWidth = [badgeLabel.text sizeWithFont:[self badgeFont]].width;

	float insetValue = [self badgeInset];

	
	if (newWidth + insetValue * 6 < self.frame.size.height) {
		newWidth = self.frame.size.height;
	}
	else {
		newWidth += insetValue * 6;
	}

	// Resizing all the layers/subviews
	self.layer.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y , newWidth, self.frame.size.height);
	gradientLayer.frame = CGRectInset(self.layer.bounds, insetValue, insetValue);
	badgeLabel.frame = CGRectMake(0, 0, self.layer.frame.size.width, self.frame.size.height);
}

#pragma mark -
#pragma mark Layout setup methods

- (void) setupBadge {
	[self setupLayers];
	[self setupText];
}

- (void) setupText {
	badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	badgeLabel.backgroundColor = [UIColor clearColor];
	badgeLabel.text = @"";
	badgeLabel.font = [self badgeFont];
	badgeLabel.textAlignment = UITextAlignmentCenter;
	badgeLabel.textColor = [UIColor whiteColor];
	[self addSubview:badgeLabel];
}

- (void) setupLayers {
	// Bg layer
	self.layer.backgroundColor = [[UIColor whiteColor] CGColor];
	self.layer.cornerRadius = [self cornerRadiusForFrame:self.frame];
	self.layer.shadowOffset = CGSizeMake(0, [self badgeInset]);
	self.layer.shadowRadius = 2;
	self.layer.shadowOpacity = 0.75;

	CGFloat insetValue = [self badgeInset];

	// Gradient Layer
	gradientLayer = [[[CAGradientLayer alloc] init] autorelease];
	gradientLayer.frame = CGRectInset(self.layer.bounds, insetValue, insetValue);
	gradientLayer.backgroundColor = [[UIColor redColor] CGColor];
	gradientLayer.cornerRadius = [self cornerRadiusForFrame:gradientLayer.frame];
	gradientLayer.shadowOpacity = 0;
		
	
	gradientLayer.colors = [NSArray arrayWithObjects: (id)[UIColor colorWithRed:1 green:0.2 blue:0.3 alpha:1.0].CGColor, 
												      (id)[UIColor colorWithRed:0.74 green:0.15 blue:0.15 alpha:1.0].CGColor,
												      nil];
	
	[self.layer addSublayer:gradientLayer];
}

#pragma mark -
#pragma mark Constraint

- (CGFloat) badgeInset {
	// Putting an inset of 10% of the total height

	return self.frame.size.height * 0.10;
}

- (CGFloat) cornerRadiusForFrame: (CGRect) frame {
	// Making the corner radius half of the height for having a perfect circle
	
	return frame.size.height / 2.0;
}

- (UIFont *) badgeFont {
	return [UIFont boldSystemFontOfSize:self.frame.size.height - (self.frame.size.height * 0.30)];
}

@end

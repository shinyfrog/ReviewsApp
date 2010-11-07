//
//  ReviewDetailsController.m
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "ReviewDetailsController.h"
#import "TraslationManager.h"
#import "UINavigationBar+BackgroundImage.h"

@implementation ReviewDetailsController

@synthesize review, waitingDialog;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil review:(Review*)_review {
    
    if (![super initWithNibName:nibName bundle:bundleOrNil]) {
        return nil;
    }
    
    self.review = _review;
    
    return self;
}

- (void) viewDidLoad {
    
    textView.text = self.review.message;
    
    NSArray* ivstars = [NSArray arrayWithObjects:star1, star2, star3, star4, star5, nil];
    int stars = [self.review.stars intValue];
    
    for (int i=0; i<stars; i++) {
        UIImageView* ivstar = [ivstars objectAtIndex:i];
        ivstar.image = [UIImage imageNamed:@"fullStar.png"];
    }

    self.title = @"Review";

    reviewAuthorLabel.text = [NSString stringWithFormat:@"%@ by %@", review.date, review.user];
    reviewVersionLabel.text = [NSString stringWithFormat:@"%@", review.version];
    reviewCoutryLabel.text = [review.appstore.store.countryCode uppercaseString];
    countryFlagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@30.png", review.appstore.store.countryCode]];
    reviewTitleLabel.text = review.title;
}

- (void) viewDidAppear:(BOOL)animated {
    self.review.viewed = [NSNumber numberWithBool:YES];

    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setTintColor:kSCNavigationBarTintColor];
    
    UIImageView *imageView = (UIImageView *)[[[navBar viewWithTag:kSCNavigationBarBackgroundImageTag] retain] autorelease];
    [imageView removeFromSuperview];
    
    UIButton* shareInsideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareInsideButton setFrame:CGRectMake(0, 0, 26, 19)];
    [shareInsideButton addTarget:self action:@selector(actions:) forControlEvents:UIControlEventTouchUpInside];
    shareInsideButton.backgroundColor = [UIColor clearColor];
    shareInsideButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin; 
    [shareInsideButton setImage:[UIImage imageNamed:@"actionIcon.png"] forState:UIControlStateNormal];
    UIBarButtonItem* shareButton = [[UIBarButtonItem alloc] initWithCustomView:shareInsideButton];
    self.navigationItem.rightBarButtonItem = shareButton;

    [navBar insertSubview:imageView atIndex:0];

}

#pragma mark -
#pragma mark actions

- (IBAction) actions:(id)sender {
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"Mark as Unread", @"Translate to english", @"Copy to Clipboard", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.navigationController.navigationBar];
    [popupQuery release];    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) { // unread
        self.review.viewed = [NSNumber numberWithBool:NO];
    } else if (buttonIndex == 1) { 

        self.waitingDialog = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        [self.view.window addSubview:self.waitingDialog];
        self.waitingDialog.delegate  = self;
        self.waitingDialog.labelText = @"Translating";
        [self.waitingDialog showWhileExecuting:@selector(translate) onTarget:self withObject:nil animated:YES];
        
        
    }  else if (buttonIndex == 2) { //clipboard

        NSMutableString* stars = [NSMutableString string];
        
        for (int i=0; i<[self.review.stars intValue]; i++) {
            [stars appendString:@"★"];
        }
                    
        NSString* message = [NSString stringWithFormat:@"%@ %@\n\n%@\n%@ %@ \n\n\%@ on %@ \n\n\n %@", 
                             self.review.appstore.app.name, self.review.version,
                             self.review.title, self.review.appstore.store.storeName, stars,
                             self.review.user, self.review.date, self.review.message
                             ];

        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = message;
    } 
}

- (void)hudWasHidden {
}

- (void)translate {
    
    @try {
        NSString* title = [TraslationManager translateString:self.review.title];
        NSString* message =  [TraslationManager translateString:self.review.message];
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title", message, @"message", nil];
        [self performSelectorOnMainThread:@selector(applyTranslations:) withObject:dic waitUntilDone:YES];
        
    }
    @catch (NSException * e) {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Unable to translate" 
                                                         message:@"Please try again later"
                                                        delegate:self
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil] autorelease];
        [alert show];
    }
    
}

- (void) applyTranslations:(NSDictionary*)translations {
    
    self.review.title = [translations objectForKey:@"title"];
    self.review.message = [translations objectForKey:@"message"];
    textView.text = self.review.message;
    reviewTitleLabel.text = review.title;      
}

@end

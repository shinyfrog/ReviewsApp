//
//  SearchAppViewController.h
//  reviewApp
//
//  Created by Danilo Bonardi on 21/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchAppViewController:UIViewController {

    NSArray* searchResults;
    NSString* appLink;
    id father;
    IBOutlet UITextField* appidTextField;
    IBOutlet UIImageView* tableFooter;
    NSOperationQueue* searchQueue;
    
}

@property (nonatomic, retain) IBOutlet NSArray* searchResults;
@property (nonatomic, retain) NSOperationQueue* searchQueue;
@property (nonatomic, retain) NSString* appLink;

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil father:(id)_father;

- (IBAction) addApplication;

- (IBAction) cancelOperation;

@end

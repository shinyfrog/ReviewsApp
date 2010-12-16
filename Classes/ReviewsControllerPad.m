//
//  ReviewsControllerPad.m
//  reviewApp
//
//  Created by Danilo Bonardi on 16/12/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "ReviewsControllerPad.h"


@implementation ReviewsControllerPad

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView { return 1; }


- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section { 
    return 0;
}

- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle *)bundleOrNil {
    if (![super initWithNibName:nibName bundle:bundleOrNil]) {
        return nil;
    }
    
    return self; 
}

- (void) viewDidLoad {

    self.navigationController.navigationBarHidden = YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self willRotateToInterfaceOrientation:[UIDevice currentDevice].orientation duration:0];
}

@end

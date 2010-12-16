//
//  ReviewsManager.m
//  reviewApp
//
//  Created by Danilo Bonardi on 24/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "ReviewsManager.h"
#import "reviewAppAppDelegate.h"
#import "TouchXML.h"
#import "ASIHTTPRequest.h"
#import "models.h"
#import "UIImage+pngThumb.h"

@implementation ReviewsManager

+ (void) getReviewsForAppStore:(AppStore*)as {
    	
    NSArray *allreviews = [as.reviews allObjects];
    
    NSMutableDictionary *reviewIdDictionary = [NSMutableDictionary dictionary];
    for (Review* r in allreviews) { [reviewIdDictionary setObject:r forKey:r.reviewId]; }
        
    NSString *sUrl = [NSString stringWithFormat:@"http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software"
                      , as.app.appId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:sUrl]];
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO];
    [request addRequestHeader:@"X-Apple-Store-Front" value:[NSString stringWithFormat:@"%@-1", as.store.storeID]]; //@"143441"
    [request addRequestHeader:@"User-Agent" value:@"iTunes/4.2 (Macintosh; U; PPC Mac OS X 10.2)"];
    [request startSynchronous];

    NSData* stringData = [request responseData];
    NSString* string = [[[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding] autorelease];
    
	CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithXMLString:string options:0 error:nil] autorelease];
	NSDictionary *mappings = [NSDictionary dictionaryWithObject:@"http://www.apple.com/itms/" forKey:@"t"];
	NSArray *resultNodes = NULL;
	resultNodes = [rssParser nodesForXPath:@"/t:Document/t:View/t:ScrollView/t:VBoxView/t:View/t:MatrixView/t:VBoxView" namespaceMappings:mappings error:nil];	
	NSArray *reviews = nil;
	

    if ([resultNodes count] != 0) {    
        reviews = [[resultNodes objectAtIndex:0] nodesForXPath:@"t:VBoxView/t:VBoxView" namespaceMappings:mappings error:nil];
        
        NSString *title =@"", *body = @"", *user = @"", *rating = @"", *date = @"", *version = @"";
        int storeOrder = 0;
        
        for (CXMLElement *elem in reviews) {
            title = [[[elem nodesForXPath:@"t:HBoxView/t:TextView/t:SetFontStyle/t:b" namespaceMappings:mappings error:nil] objectAtIndex:0] stringValue];
            body = [[[elem nodesForXPath:@"t:TextView/t:SetFontStyle" namespaceMappings:mappings error:nil] objectAtIndex:0] stringValue];
            rating = [[[[elem nodesForXPath:@"t:HBoxView/t:HBoxView/t:HBoxView" namespaceMappings:mappings error:nil] objectAtIndex:0] attributeForName:@"alt"] stringValue];
            
            NSArray *userBlock = [elem nodesForXPath:@"t:HBoxView/t:TextView/t:SetFontStyle/t:GotoURL/t:b" namespaceMappings:mappings error:nil];
            if ([userBlock count] > 0) {
                user = [[[userBlock objectAtIndex:0] stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            } else {
                user = @"Anonimous";
            }

            NSString *versionDateBlock = [[[elem nodesForXPath:@"t:HBoxView/t:TextView/t:SetFontStyle" namespaceMappings:mappings error:nil] objectAtIndex:1] stringValue];
            NSArray *component = [versionDateBlock componentsSeparatedByString:@"\n"];
            
            @try {
                if ([component count] > 2) {
                    date = [[component objectAtIndex:8] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    version = [[component objectAtIndex:5] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                }
            } @catch (NSException * e) {
                SFLog(@"Store %@ - unble to catch date/version", as.store.storeName);
            }
            
            [ReviewsManager addReviewWithTitle:title 
                                          body:body 
                                          user:user 
                                        rating:rating 
                                          date:date 
                                       version:version 
                                     storeOder:storeOrder
                                      appStore:as
                                       reviews:reviewIdDictionary];

            storeOrder ++;

            SFLog(@"%@, %@, %@, %@, %@, %@", title, body, user, rating, date, version);
        }    
    }
    
	
    NSArray *resultNodes2 = NULL;
	resultNodes2 = [rssParser nodesForXPath:@"/t:Document/t:View" namespaceMappings:mappings error:nil];
    
    if ([resultNodes2 count] != 0) {
    
        NSArray *Hbox= [[resultNodes2 objectAtIndex:0] nodesForXPath:@"t:ScrollView/t:VBoxView/t:View/t:MatrixView/t:VBoxView/t:HBoxView" namespaceMappings:mappings error:nil];

        //App name
        if (as.app.name == nil || [as.app.name length] == 0) {
            NSArray *textView = [[Hbox objectAtIndex:0] nodesForXPath:@"t:VBoxView/t:VBoxView/t:MatrixView/t:VBoxView/t:TextView" namespaceMappings:mappings error:nil];
            NSString *name = [[[[textView objectAtIndex:0] nodesForXPath:@"t:SetFontStyle/t:GotoURL" namespaceMappings:mappings error:nil] objectAtIndex:0] stringValue];
            name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            as.app.name = name;
            SFLog(@"app Name : %@", name);
        }
        
		
        //App Image
        if (as.app.image == nil || [as.app.image length] == 0) {
            NSArray *pictureView = [[Hbox objectAtIndex:0] nodesForXPath:@"t:VBoxView/t:VBoxView/t:MatrixView/t:GotoURL/t:View/t:PictureView" namespaceMappings:mappings error:nil];
            NSString *imageURL = [[[pictureView objectAtIndex:0] attributeForName:@"url"] stringValue];
            SFLog(@"imageURL : %@", imageURL);
            [ReviewsManager saveImageWithUrl:imageURL inApp:as.app];
        }
        
        @try {
            NSArray *vbox = [[Hbox objectAtIndex:0] nodesForXPath:@"t:VBoxView" namespaceMappings:mappings error:nil];
            NSArray *test = [[vbox objectAtIndex:1] nodesForXPath:@"t:VBoxView/t:View/t:View/t:View/t:VBoxView/t:Test" namespaceMappings:mappings error:nil];
            NSArray *hbox = [[test objectAtIndex:1] nodesForXPath:@"t:VBoxView/t:HBoxView" namespaceMappings:mappings error:nil];
            NSArray *vb = [[hbox objectAtIndex:0] nodesForXPath:@"t:VBoxView" namespaceMappings:mappings error:nil];
            NSArray *hb = [[vb objectAtIndex:2] nodesForXPath:@"t:HBoxView" namespaceMappings:mappings error:nil];
            NSString *ratingStore = [[[hb objectAtIndex:0] attributeForName:@"alt"] stringValue];
            SFLog(@"Store Rating : %@", ratingStore);

            float storeStars = [[ratingStore substringToIndex:1] floatValue];

            if ([ratingStore rangeOfString:@"half"].location != NSNotFound) {
                storeStars += 0.5;
            }
            
            as.stars = [NSNumber numberWithFloat:storeStars];
            
        }
        @catch (NSException * e) {
            as.stars = [NSNumber numberWithFloat:0];
        }
        
    } else {
        [NSException raise:@"Application Id Not Valid" format:@"Application Id Not Valid"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }
    
    SFLog(@"Stop");
    
}

+ (void) addReviewWithTitle:(NSString*)title body:(NSString*)body user:(NSString*)user rating:(NSString*)rating 
                       date:(NSString*)date version:(NSString*)version storeOder:(int)storeOrder 
                   appStore:(AppStore*)as reviews:(NSDictionary*) reviews

{
    
    NSMutableDictionary* dataDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [dataDict setObject:title forKey:@"title"];
    [dataDict setObject:body forKey:@"body"];
    [dataDict setObject:user forKey:@"user"];
    [dataDict setObject:rating forKey:@"rating"];
    [dataDict setObject:date forKey:@"date"];
    [dataDict setObject:version forKey:@"version"];
    [dataDict setObject:[NSNumber numberWithInt:storeOrder] forKey:@"storeOrder"];
    [dataDict setObject:as forKey:@"as"];
    [dataDict setObject:reviews forKey:@"reviews"];
    
    ReviewsManager* manager = [[[ReviewsManager alloc] init] autorelease];
    
    [manager performSelectorOnMainThread:@selector(addReviewThreadSafe:) withObject:dataDict waitUntilDone:YES];
    

}

- (void) addReviewThreadSafe:(NSDictionary*)dataDict {
    
    NSString* title = [dataDict objectForKey:@"title"];
    NSString* body = [dataDict objectForKey:@"body"];
    NSString* user = [dataDict objectForKey:@"user"];
    NSString* rating = [dataDict objectForKey:@"rating"];
    NSString* date = [dataDict objectForKey:@"date"];
    NSString* version = [dataDict objectForKey:@"version"];
    NSNumber* storeOrder = [dataDict objectForKey:@"storeOrder"];
    AppStore* as = [dataDict objectForKey:@"as"];
    NSDictionary* reviews = [dataDict objectForKey:@"reviews"];
    
    //Generate review id
    NSString* reviewId = [NSString stringWithFormat:@"%@%@%@", title, user, date];
    Review* rev = [reviews objectForKey:reviewId];
    reviewAppAppDelegate* app = [[UIApplication sharedApplication] delegate];
    
    if (rev == nil) {
        //Add        
        rev = [Review insertInManagedObjectContext:app.managedObjectContext];
        rev.reviewId = reviewId;
        rev.insertionDate = [NSDate date];
    }
    
    rev.title = title;
    rev.message = body;
    rev.user = user;
    rev.stars = [NSNumber numberWithInt:[[rating substringToIndex:1] intValue]];
    rev.date = date;
    rev.version = version;

    rev.storeOrder = storeOrder;
    
    [[as reviewsSet] addObject:rev];    
    
}


+ (void) syncAllApps {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    reviewAppAppDelegate* app    = [[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:@"AppStore" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"app.order" ascending:YES] autorelease];
    NSSortDescriptor *sortDescriptor2 = [[[NSSortDescriptor alloc] initWithKey:@"insertionDate" ascending:NO] autorelease];
    NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, sortDescriptor2, nil] autorelease];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error=nil;
    NSArray *appstores = [app.managedObjectContext executeFetchRequest:fetchRequest error:&error];    
    
    for (AppStore* as in appstores) {
        [ReviewsManager getReviewsForAppStore:as];
    }
    
    [app.managedObjectContext performSelectorOnMainThread:@selector(save:) 
                                               withObject:nil 
                                            waitUntilDone:YES];

    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastSync"]; 
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;    

}


+ (void) newAppSync:(App*)newApp {
    
    reviewAppAppDelegate* app    = [[UIApplication sharedApplication] delegate];    

    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;    
    
	
    for (AppStore* as in newApp.stores) {
        [ReviewsManager getReviewsForAppStore:as];
    }
	
    
    [app.managedObjectContext performSelectorOnMainThread:@selector(save:) 
                                               withObject:nil 
                                            waitUntilDone:YES];

    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;    
    
}

+ (void) saveImageWithUrl:(NSString*)imageURL inApp:(App*)app {

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageURL]];
    [request startSynchronous];
    NSData* imageData = [request responseData];
    
    if (imageData == nil) { return; }
    
    UIImage* appIcon = [UIImage imageWithData:imageData];
    NSData* thumb = [appIcon pngThumbWithMaxWidth:100 andMaxHeight:100];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString* picturesDirectory = [NSMutableString stringWithString:[paths objectAtIndex:0]]; //document directory
    [picturesDirectory appendString:@"/icons/"];

    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];

    if ( ![fileManager fileExistsAtPath:picturesDirectory isDirectory:NULL] ) {
        NSError* error = nil;
        [fileManager createDirectoryAtPath:picturesDirectory withIntermediateDirectories:NO attributes:nil error:&error];        
        if (error) { SFLog(@"Error Creating pictures folder"); }
    }
    
    [picturesDirectory appendString:[NSString stringWithFormat:@"%@.png", app.appId]];
    
    [thumb writeToFile:picturesDirectory atomically:YES];
    app.image = picturesDirectory;
}


@end

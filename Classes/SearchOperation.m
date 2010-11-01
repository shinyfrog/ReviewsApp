//
//  SearchOperation.m
//  reviewApp
//
//  Created by Danilo Bonardi on 28/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "SearchOperation.h"
#import "ASIHTTPRequest.h"
#import "CJSONDeserializer.h"
#import "SearchAppViewController.h"

@implementation SearchOperation

@synthesize father, searchString;

- (void)main {
    NSString *sUrl = [NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=%@ site:http://itunes.apple.com"
                      ,searchString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[sUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]];    
    [request startSynchronous];
    
    NSError* error = nil;
    NSDictionary* obj = (NSDictionary*)[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error];

    if (obj == nil) { return; }

    NSDictionary* responseData = [obj objectForKey:@"responseData"];
    
    NSMutableDictionary* _results = [NSMutableDictionary dictionary];
    
    for (NSDictionary* searchData in (NSArray*)[responseData objectForKey:@"results"]) {
        
        NSString* url = [searchData objectForKey:@"unescapedUrl"];
        if ([url rangeOfString:@"/app/"].location == NSNotFound) { continue; }
        
        NSString* appid = [url substringFromIndex:[url rangeOfString:@"/" options:NSBackwardsSearch].location+3];
        
        NSInteger qmarkIndex = [appid rangeOfString:@"?"].location;
        if (qmarkIndex != NSNotFound) {
            appid = [appid substringToIndex:qmarkIndex];            
        }
        
        NSInteger boIndex = [appid rangeOfString:@"%3"].location;        
        if (boIndex != NSNotFound) {
            appid = [appid substringToIndex:boIndex];  
        }
        
        if ([_results objectForKey:appid] == nil) {
            NSMutableDictionary* cleanData = [NSMutableDictionary dictionaryWithDictionary:searchData];
            [cleanData setObject:appid forKey:@"appid"];
            [_results setObject:cleanData forKey:appid];
        }
    }

    [father performSelectorOnMainThread:@selector(setSearchResults:) withObject:[_results allValues] waitUntilDone:YES];
    [((SearchAppViewController*)father).searchDisplayController.searchResultsTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

}

@end

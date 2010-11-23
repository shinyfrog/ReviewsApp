//
//  TraslationManager.m
//  reviewApp
//
//  Created by Danilo Bonardi on 01/11/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "TraslationManager.h"
#import "CJSONDeserializer.h"
#import "ASIHTTPRequest.h"

@implementation TraslationManager

+ (NSString*)translateString:(NSString*)text {
    
    NSString *sUrl = [NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=%@&langpair=%@en"
                      , [text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
                      , [@"|" stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
                      ];
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:sUrl]];
    [request addRequestHeader:@"HTTP_REFERER" value:@"http://www.shinyfrog.net"];
    [request startSynchronous];

    NSError* error;
    NSDictionary* obj = (NSDictionary*)[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error];
    
    if (obj == nil) { 
        [NSException raise:@"Unable to tranlsate" format:@""];
    }
    
    NSDictionary* responseData = [obj objectForKey:@"responseData"];
    NSString* translatedText = [responseData objectForKey:@"translatedText"];
    
    return translatedText;
    
}

@end

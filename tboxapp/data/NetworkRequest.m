//
//  NetworkRequest.m
//  whatnowpad
//
//  Created by Milan Kazarka on 12/12/17.
//  Copyright © 2017 Milan Kazarka. All rights reserved.
//

#import "NetworkRequest.h"
#import "Common.h"
#import "NSDictionary+typeSafeSearch.h"

@implementation NetworkRequest

// #todo - stop using & modernize
+(void)performRawRequest:(NSMutableURLRequest*)request withCompletion:(void (^)(NSData*))completionBlock {
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!data)
                                   completionBlock(nil);
                               NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                               if (httpResponse) {
                                   if (httpResponse.statusCode!=200) {
                                       NSLog(@" error(%@)",[NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
                                       completionBlock(nil);
                                       return;
                                   }
                               } else {
                                   
                                   completionBlock(nil);
                                   return;
                               }
                               completionBlock(data);
                           }];
}

+(void)performRequest:(NSMutableURLRequest*)request withCompletion:(void (^)(id))completionBlock {
    
    [NetworkRequest performRawRequest:request withCompletion:^(NSData *data) {
        if (data) {
            id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:nil];
            if (json)
                completionBlock(json);
            else
                completionBlock(data);
        } else {
            completionBlock(nil);
        }
    }];
}

+(BOOL)apiRequestWithCompleteURL:(NSString*)url completion:(void (^)(id))completionBlock {
    if (!url || !completionBlock)
        return NO;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    
    [NetworkRequest performRequest:request withCompletion:completionBlock];
    
    return YES;
}

@end

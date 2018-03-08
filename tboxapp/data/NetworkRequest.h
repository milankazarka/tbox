//
//  NetworkRequest.h
//  whatnowpad
//
//  Created by Milan Kazarka on 12/12/17.
//  Copyright © 2017 Milan Kazarka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequest : NSObject

+(void)performRawRequest:(NSMutableURLRequest*)request withCompletion:(void (^)(NSData*))completionBlock;
+(BOOL)apiRequestWithCompleteURL:(NSString*)url completion:(void (^)(id))completionBlock;

@end

//
//  Profile.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject

+(id)shared;
-(void)onLoginWithUsername:(NSString*)username andPassword:(NSString*)password withCompletion:(void (^)(NSError*))completionBlock;
-(void)onRegisterWithUsername:(NSString*)username andPassword:(NSString*)password;

@end

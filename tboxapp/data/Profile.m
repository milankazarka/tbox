//
//  Profile.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "Profile.h"

@implementation Profile

+(id)shared {
    static Profile *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Profile alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)onLoginWithUsername:(NSString*)username andPassword:(NSString*)password withCompletion:(void (^)(NSError*))completionBlock {
    
    // keychain or web based login in real life scenario
    
    NSString *storedUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *storedPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (storedPassword && storedPassword) {
        if ([storedUsername isEqualToString:username] && [storedPassword isEqualToString:password]) {
            completionBlock(nil);
            return;
        }
    }
    completionBlock([[NSError alloc] init]);
}

-(void)onRegisterWithUsername:(NSString*)username andPassword:(NSString*)password {
    if (!username || !password) {
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end

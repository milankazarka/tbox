//
//  State.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "State.h"
#import "LocationLogger.h"
#import "Modules.h"

@implementation State

+(State*)shared {
    static State *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[State alloc] init];
    });
    return sharedInstance;
}

/** we concatenate different module & service updates into one state update
 */
-(id)init {
    self = [super init];
    if (self) {
        
        self.modules = [[Modules alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onLocationUpdated)
                                                     name:@"onLocationUpdated" object:nil];
        
        [LocationLogger shared]; // initializes automatically
    }
    return self;
}

-(void)onLocationUpdated {
    NSLog(@"State onLocationUpdated");
    [self.modules onLocationUpdated];
    [self onStateUpdated];
}

-(void)onStateUpdated {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onStateUpdated" object:nil];
}

@end

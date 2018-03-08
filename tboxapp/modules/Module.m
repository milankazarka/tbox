//
//  Module.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "Module.h"

@implementation Module

-(id)init {
    self = [super init];
    if (self) {
        self.ready = NO;
        self.name = @"module name";
        self.delegate = nil;
    }
    return self;
}

-(void)onModuleUpdate {
    self.ready = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onModuleUpdate" object:self];
    if (self.delegate) {
        [self.delegate onModuleUpdate:self];
    }
}

-(void)onLocationUpdate {
    NSLog(@"Module onLocationUpdate");
}

@end

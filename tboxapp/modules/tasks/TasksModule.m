//
//  TasksModule.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "TasksModule.h"

@implementation TasksModule

-(id)init {
    self = [super init];
    if (self) {
        self.name = @"Tasks";
        
        NSArray *tasks = [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];
        if (!tasks) {
            [[NSUserDefaults standardUserDefaults] setObject:[[NSArray alloc] init] forKey:@"tasks"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return self;
}

// access at runtime

-(void)setTasks:(NSMutableArray*)tasks {
    [[NSUserDefaults standardUserDefaults] setObject:tasks forKey:@"tasks"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSMutableArray*)tasks {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];
}

@end

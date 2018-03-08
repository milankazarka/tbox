//
//  Modules.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "Modules.h"
#import "WeatherModule.h"
#import "NewsModule.h"
#import "SportModule.h"
#import "TasksModule.h"
#import "PhotosModule.h"
#import "ClothesModule.h"

@implementation Modules

-(id)init {
    self = [super init];
    if (self) {
        self.modules = [[NSMutableArray alloc] init];
        [self.modules addObject:[[WeatherModule alloc] init]];
        [self.modules addObject:[[NewsModule alloc] init]];
        [self.modules addObject:[[SportModule alloc] init]];
        [self.modules addObject:[[PhotosModule alloc] init]];
        [self.modules addObject:[[TasksModule alloc] init]];
        [self.modules addObject:[[ClothesModule alloc] init]];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onModuleUpdate:)
                                                     name:@"onModuleUpdate" object:nil];
    }
    return self;
}

-(Module*)getModuleClass:(Class)classType {
    for(Module *module in self.modules) {
        if ([module isKindOfClass:classType])
            return module;
    }
    return nil;
}

-(void)onModuleUpdate:(NSNotification*)notif {
    if (notif) {
        id object = notif.object;
        if (object) {
        }
    }
}

-(void)onLocationUpdated {
    for(Module *module in self.modules) {
        [module onLocationUpdate];
    }
}

@end

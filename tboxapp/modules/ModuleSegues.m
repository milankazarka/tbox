//
//  ModuleSegues.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleSegues.h"
#import "WeatherModule.h"
#import "NewsModule.h"
#import "SportModule.h"
#import "PhotosModule.h"
#import "TasksModule.h"

@implementation ModuleSegues

+(NSString*)detailScreenSequeForModule:(Module*)module {
    if (!module)
        return nil;
    if ([module isKindOfClass:[NewsModule class]]) {
        return @"pushNews";
    } else if ([module isKindOfClass:[SportModule class]]) {
        return @"pushSport";
    } else if ([module isKindOfClass:[TasksModule class]]) {
        return @"pushTasks";
    } else if ([module isKindOfClass:[PhotosModule class]]) {
        return @"pushPhotos";
    }
    return nil;
}

@end

//
//  ModuleTileContentDataViewTasks.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentDataViewTasks.h"
#import "TasksModule.h"

@implementation ModuleTileContentDataViewTasks

-(void)setModule:(Module *)module {
    _module = module;
    if (_module) {
        if ([_module isKindOfClass:[TasksModule class]]) {
            //
        }
    }
}

@end

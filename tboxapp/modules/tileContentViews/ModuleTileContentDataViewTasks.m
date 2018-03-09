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
            
            // simpleton, fast approach
            
            NSArray *shownItems = @[self.task1,self.task2,self.task3];
            //
            TasksModule *tm = (TasksModule*)_module;
            NSMutableArray *tasks = tm.tasks;
            int index = 0;
            for(NSDictionary *task in tasks) {
                NSString *field = [task objectForKey:@"field"];
                NSString *isOn = [task objectForKey:@"switch"];
                BOOL bisOn = NO;
                if ([isOn isEqualToString:@"true"])
                    bisOn = YES;
                if (bisOn && index<3) {
                    UILabel *label = [shownItems objectAtIndex:index];
                    label.text = field;
                    index++;
                }
            }
        }
    }
}

@end

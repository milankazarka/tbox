//
//  TasksViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "TasksViewController.h"
#import "TasksModule.h"
#import "State.h"
#import "Modules.h"

@interface TasksViewController ()

@end

@implementation TasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // just doing a simple custom list of views for now - table or collection would be better
    //
    self.customEditables = [[NSMutableArray alloc] init];
    CGFloat offset = 20.0f;
    CGFloat y = 66.0f;
    for(int n = 0; n < 5; n++) {
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(offset,y,self.view.frame.size.width-(2.0f*offset),50.0f)];
        CGRect fieldRect = customView.bounds;
        fieldRect.size.width-=40.0f;
        UITextField *field = [[UITextField alloc] initWithFrame:fieldRect];
        field.textColor = [UIColor whiteColor];
        field.placeholder = @"task text placeholder";
        field.tag = n;
        [field addTarget:self
                        action:@selector(textFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
        [customView addSubview:field];
        UISwitch *csw = [[UISwitch alloc] initWithFrame:CGRectMake(field.frame.size.width,0.0f,40.0f,50.0f)];
        [csw addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
        csw.tag = n;
        [customView addSubview:csw];
        y+=60.0f;
        [self.view addSubview:customView];
        NSMutableDictionary *rep = [[NSMutableDictionary alloc] init];
        [rep setObject:field forKey:@"field"];
        [rep setObject:csw forKey:@"switch"];
        [self.customEditables addObject:rep];
    }
    
    NSMutableArray *tasks = ((TasksModule*)[[State shared].modules getModuleClass:[TasksModule class]]).tasks;
    if (tasks) {
        int n = 0;
        for(NSDictionary *task in tasks) {
            NSDictionary *editable = [self.customEditables objectAtIndex:n];
            UITextField *field = [editable objectForKey:@"field"];
            UISwitch *csw = [editable objectForKey:@"switch"];
            field.text = [task objectForKey:@"field"];
            NSString *isOn = [task objectForKey:@"switch"];
            BOOL bisOn = NO;
            if ([isOn isEqualToString:@"true"])
                bisOn = YES;
            csw.on = bisOn;
            n++;
        }
    }
}

-(NSMutableArray*)createSavestate {
    NSMutableArray *savestate = [[NSMutableArray alloc] init];
    for(NSDictionary *rep in self.customEditables) {
        UITextField *field = [rep objectForKey:@"field"];
        UISwitch *csw = [rep objectForKey:@"switch"];
        NSString *bv = [NSString stringWithFormat:@"%s", csw.isOn ? "true" : "false"];
        [savestate addObject:@{@"field":field.text,@"switch":bv}];
    }
    return savestate;
}

-(void)saveState {
    // #todo - could be that the module is associated with teh VC, so that we don't backward fetch it
    ((TasksModule*)[[State shared].modules getModuleClass:[TasksModule class]]).tasks = [self createSavestate];
}

- (void)setState:(UISwitch*)sender {
    [self saveState];
}

-(void)textFieldDidChange:(UITextField*)field {
    [self saveState];
}

@end

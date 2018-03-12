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
    self.customEditables = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadSaveState];
}

-(void)update {
    
    for(NSDictionary *editable in self.customEditables) {
        UIView *customView = [editable objectForKey:@"view"];
        if (customView)
            if (customView.superview)
                [customView removeFromSuperview];
    }
    
    NSMutableArray *tasks = ((TasksModule*)[[State shared].modules getModuleClass:[TasksModule class]]).tasks;
    if (!tasks)
        tasks = [[NSMutableArray alloc] init];
    
    self.customEditables = [[NSMutableArray alloc] init];
    CGFloat offset = 0.0f;
    CGFloat y = 0.0f;
    for(int n = 0; n < tasks.count; n++) {
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(offset,y,self.scrollView.frame.size.width-(2.0f*offset),50.0f)];
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
        UISwitch *csw = [[UISwitch alloc] initWithFrame:CGRectMake(field.frame.size.width-10.0f,0.0f,40.0f,50.0f)];
        [csw addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
        csw.tag = n;
        [customView addSubview:csw];
        y+=60.0f;
        [self.scrollView addSubview:customView];
        NSMutableDictionary *rep = [[NSMutableDictionary alloc] init];
        [rep setObject:field forKey:@"field"];
        [rep setObject:csw forKey:@"switch"];
        [rep setObject:customView forKey:@"view"];
        [self.customEditables addObject:rep];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,y);

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

-(void)loadSaveState {
    [self update];
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

-(IBAction)onNewTask:(id)sender {
    NSMutableArray *saveState = [self createSavestate];
    [saveState insertObject:@{@"field":@"new",@"switch":@"false"} atIndex:0];
    ((TasksModule*)[[State shared].modules getModuleClass:[TasksModule class]]).tasks = saveState;
    [self update];
}

@end

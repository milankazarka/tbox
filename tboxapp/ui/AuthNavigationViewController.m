//
//  AuthNavigationViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "AuthNavigationViewController.h"

@interface AuthNavigationViewController ()

@end

@implementation AuthNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onLoginSuccess)
                                                 name:@"onLoginSuccess" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)onLoginSuccess {
    [self performSegueWithIdentifier:@"presentDashboard" sender:self];
}

@end

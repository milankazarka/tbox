//
//  LoginViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "LoginViewController.h"
#import "Profile.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.usernameField.text = @"";
    self.passwordField.text = @"";
}

-(void)onLoginSuccess {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onLoginSuccess" object:nil];
}

-(void)onLoginFieldsEmpty {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Warning"
                                  message:@"please fill out all fields"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

-(void)notRegisteredOrBad {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Warning"
                                  message:@"not registered or bad credentials"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

/** I guess that we should wait for loading the online resource data until we log-in, but for the sake of simplicity & speed this is done in parallel now
 */
-(IBAction)onLogin:(id)sender {
    if (!self.usernameField.text.length || !self.passwordField.text.length) {
        [self onLoginFieldsEmpty];
        return;
    }
    [[Profile shared] onLoginWithUsername:self.usernameField.text andPassword:self.passwordField.text withCompletion:^(NSError *error) {
        if (!error) {
            [self onLoginSuccess];
        } else {
            [self notRegisteredOrBad];
        }
    }];
}

-(IBAction)onRegister:(id)sender {
    // handled using storyboards, deprecated
}

@end

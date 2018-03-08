//
//  RegisterViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "RegisterViewController.h"
#import "Profile.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(IBAction)onRegister:(id)sender {
    // keychain or some online process in real life scenario
    if (self.username.text.length>0 && self.password.text.length>0) {
        [[Profile shared] onRegisterWithUsername:self.username.text andPassword:self.password.text];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self onEmptyFields];
    }
}

-(void)onEmptyFields {
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

@end

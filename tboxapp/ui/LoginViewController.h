//
//  LoginViewController.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak,nonatomic) IBOutlet UITextField *usernameField;
@property (weak,nonatomic) IBOutlet UITextField *passwordField;

-(IBAction)onLogin:(id)sender;
-(IBAction)onRegister:(id)sender;

@end

//
//  RegisterViewController.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak,nonatomic) IBOutlet UITextField *username;
@property (weak,nonatomic) IBOutlet UITextField *password;
@property (weak,nonatomic) IBOutlet UIButton *registerBtn;

-(IBAction)onRegister:(id)sender;

@end

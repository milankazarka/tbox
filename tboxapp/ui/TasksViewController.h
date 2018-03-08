//
//  TasksViewController.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TasksViewController : UIViewController

// #todo - should be a tableview, not static items

@property (weak,nonatomic) IBOutlet UITextField *entry1;
@property (weak,nonatomic) IBOutlet UITextField *entry2;
@property (weak,nonatomic) IBOutlet UITextField *entry3;
@property (weak,nonatomic) IBOutlet UITextField *entry4;
@property (weak,nonatomic) IBOutlet UISwitch *switch1;
@property (weak,nonatomic) IBOutlet UISwitch *switch2;
@property (weak,nonatomic) IBOutlet UISwitch *switch3;
@property (weak,nonatomic) IBOutlet UISwitch *switch4;

@end

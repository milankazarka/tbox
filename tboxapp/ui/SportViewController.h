//
//  SportViewController.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic) IBOutlet UITextField *textField;
@property (weak,nonatomic) IBOutlet UITableView *tableView;

-(IBAction)onSearch:(id)sender;

@end

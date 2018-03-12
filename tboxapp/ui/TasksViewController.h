//
//  TasksViewController.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TasksViewController : UIViewController

@property (strong,nonatomic) NSMutableArray *customEditables;
@property (weak,nonatomic) IBOutlet UIScrollView *scrollView;

-(IBAction)onNewTask:(id)sender;

@end

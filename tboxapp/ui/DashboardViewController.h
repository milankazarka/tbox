//
//  DashboardViewController.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak,nonatomic) IBOutlet UICollectionView *collectionView;

@end

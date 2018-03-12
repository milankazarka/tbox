//
//  ModuleTileContentDataViewTasks.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentData.h"

@interface ModuleTileContentDataViewTasks : ModuleTileContentData

// #todo - should be collection or other custom list

@property (weak,nonatomic) IBOutlet UILabel *task1;
@property (weak,nonatomic) IBOutlet UILabel *task2;
@property (weak,nonatomic) IBOutlet UILabel *task3;

@property (weak,nonatomic) IBOutlet UIImageView *iv1;
@property (weak,nonatomic) IBOutlet UIImageView *iv2;
@property (weak,nonatomic) IBOutlet UIImageView *iv3;

@end

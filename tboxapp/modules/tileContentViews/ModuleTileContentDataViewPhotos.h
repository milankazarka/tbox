//
//  ModuleTileContentDataViewPhotos.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentData.h"

@interface ModuleTileContentDataViewPhotos : ModuleTileContentData

// actually fixed to 4, but doing this dynamically here

@property (strong,nonatomic) NSMutableArray *previews;

// fast approach, otherwise do it smarter
@property (weak,nonatomic) IBOutlet UIView *innerFrame;
@property (weak,nonatomic) IBOutlet UIImageView *prev1;
@property (weak,nonatomic) IBOutlet UIImageView *prev2;
@property (weak,nonatomic) IBOutlet UIImageView *prev3;
@property (weak,nonatomic) IBOutlet UIImageView *prev4;

@end

//
//  ModuleTile.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleTileContent.h"

@protocol ModuleTileDelegate <NSObject>

@end

@class Module;

@interface ModuleTile : UICollectionViewCell

@property (strong,nonatomic) ModuleTileContent *content;
@property (strong,nonatomic) Module *module;

-(void)loadContentView;

@end

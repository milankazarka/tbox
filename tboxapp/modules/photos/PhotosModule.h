//
//  PhotosModule.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h> // we work with UIImage objects
#import "Module.h"

@interface PhotosModule : Module

@property (strong,nonatomic) NSMutableArray *previewImages;

-(BOOL)storeImage:(UIImage*)image atCellIndex:(NSUInteger)index;
-(UIImage*)imageAtCellIndex:(NSUInteger)index;

@end

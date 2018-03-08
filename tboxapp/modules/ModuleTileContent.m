//
//  ModuleTileContent.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContent.h"

@implementation ModuleTileContent

-(void)didMoveToSuperview {
    self.innerFrame.layer.cornerRadius = 5.0f;
    self.innerFrame.clipsToBounds = YES;
}

@end

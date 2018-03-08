//
//  ModuleViews.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Module.h"

@class ModuleTileContentData;

@interface ModuleViews : NSObject

+(ModuleTileContentData*)tileContentDataViewForModule:(Module*)module;

@end

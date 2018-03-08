//
//  ModuleTileContentData.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Module;

@interface ModuleTileContentData : UIView {
    @protected Module *_module;
}
@property (strong,nonatomic) Module *module;
@end

//
//  State.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Modules;

@interface State : NSObject

@property (strong,nonatomic) Modules *modules;

+(State*)shared;

@end

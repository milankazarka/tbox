//
//  Modules.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Module;

@interface Modules : NSObject

@property (strong,nonatomic) NSMutableArray *modules;

-(Module*)getModuleClass:(Class)classType; // get module by class type
-(void)onLocationUpdated;

@end

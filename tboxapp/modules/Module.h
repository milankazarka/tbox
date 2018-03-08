//
//  Module.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModuleDelegate <NSObject>
-(void)onModuleUpdate:(id)module;
@end

@interface Module : NSObject

@property (strong,nonatomic) NSString *name;
@property (weak,nonatomic) NSObject<ModuleDelegate> *delegate;
@property (assign,nonatomic) BOOL ready;

-(void)onModuleUpdate;
-(void)onLocationUpdate;

@end

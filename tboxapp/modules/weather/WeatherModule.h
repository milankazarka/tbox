//
//  WeatherModule.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "Module.h"

@interface WeatherModule : Module

@property (strong,nonatomic) NSDictionary *currentWeatherDataRaw;

-(void)onLocationUpdate;
-(void)updateWithCompletion:(void (^)())completionBlock;

@end

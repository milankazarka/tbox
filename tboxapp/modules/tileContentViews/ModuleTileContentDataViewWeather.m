//
//  ModuleTileContentDataViewWeather.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentDataViewWeather.h"
#import "Module.h"
#import "WeatherModule.h"
#import "NSDictionary+typeSafeSearch.h"
#import <MWFeedParser/MWFeedParser.h>

@implementation ModuleTileContentDataViewWeather

-(void)loadWeatherModuleData:(WeatherModule*)wm {
    if (!wm)
        return;
    self.locationLabel.text = [wm.currentWeatherDataRaw objectForKey:@"name"];
    NSNumber *kelvin = [wm.currentWeatherDataRaw
                        objectAtPath:@[[NSDictionary class],@"main"],@[[NSNumber class],@"temp"], nil];
    if (kelvin) {
        double dkelvin = kelvin.doubleValue;
        dkelvin -= 273.15f;
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f",dkelvin];
    }
    NSArray *weather = [wm.currentWeatherDataRaw objectForKey:@"weather"];
    if (weather) {
        if (weather.count>0) {
            NSDictionary *firstWeather = [weather objectAtIndex:0];
            if (firstWeather) {
                NSString *icon = [firstWeather objectForKey:@"icon"];
                if (icon) {
                    
                    // a lazy approach for now
                    
                    NSArray *sunny = @[@"01"];
                    NSArray *cloudy = @[@"02",@"03",@"04"];
                    NSArray *rainy = @[@"09",@"10",@"11",@"13",@"50"];
                    NSString *codeStr = [icon substringToIndex:2];
                    for(NSString *match in sunny) {
                        if ([codeStr isEqualToString:match])
                            self.weatherIcon.image = [UIImage imageNamed:@"Sun_icon.png"];
                    }
                    for(NSString *match in cloudy) {
                        if ([codeStr isEqualToString:match])
                            self.weatherIcon.image = [UIImage imageNamed:@"Clouds_icon.png"];
                    }
                    for(NSString *match in rainy) {
                        if ([codeStr isEqualToString:match])
                            self.weatherIcon.image = [UIImage imageNamed:@"Rain_icon.png"];
                    }
                }
            }
        }
    }
}

-(void)setModule:(Module *)module {
    _module = module;
    if (_module) {
        if ([_module isKindOfClass:[WeatherModule class]]) {
            WeatherModule *wm = (WeatherModule*)_module;
            
            if (!wm.currentWeatherDataRaw) {
                [wm updateWithCompletion:^{
                    [self loadWeatherModuleData:wm];
                }];
            } else {
                [self loadWeatherModuleData:wm];
            }
        }
    }
}

@end

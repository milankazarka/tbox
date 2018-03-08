//
//  WeatherModule.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "WeatherModule.h"
#import "NetworkRequest.h"
#import "LocationLogger.h"
#import "Common.h"

@interface WeatherModule ()
@property (strong,nonatomic) NSString *currentUpdateUrl;
@end

@implementation WeatherModule

-(id)init {
    self = [super init];
    if (self) {
        self.name = @"Weather";
        self.currentWeatherDataRaw = nil;
        [self update];
    }
    return self;
}

-(NSString*)currentUpdateUrl {
    if (![LocationLogger shared].currentLocation)
        return nil;
    CLLocationCoordinate2D coordinates = [LocationLogger shared].currentLocation.coordinate;
    
    return [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%@",coordinates.latitude,coordinates.longitude,_APPID_WEATHER];
}

-(void)updateWithCompletion:(void (^)())completionBlock {
    NSString *currentUpdateUrl = self.currentUpdateUrl;
    if (!currentUpdateUrl)
        return;
    
    [NetworkRequest apiRequestWithCompleteURL:currentUpdateUrl completion:^(id data) {
        if (data) {
            NSLog(@"WeatherModule update; got data");
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDict = (NSDictionary*)data; // I always do this for the sake of being clear
                self.currentWeatherDataRaw = [[NSDictionary alloc] initWithDictionary:dataDict];
                if (completionBlock) {
                    completionBlock();
                }
            }
        } else {
            // #todo - error response
        }
    }];
}

-(void)update {
    NSLog(@"WeatherModule update");
    [self updateWithCompletion:nil];
    [self onModuleUpdate];
}

-(void)onLocationUpdate {
    [super onLocationUpdate];
    [self update];
}

@end

//
//  LocationLogger.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "LocationLogger.h"
#import <UIKit/UIKit.h>

@implementation LocationLogger

+(LocationLogger*)shared {
    static LocationLogger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationLogger alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if (self) {
        [self startUpdatingLocation];
    }
    return self;
}

-(void)startUpdatingLocation {
    self.currentLocation = nil;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"LocationLogger didFailWithError");
    
#if TARGET_OS_SIMULATOR
    // if we're running in the simulator we automatically fallback to London coordinates
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:51.509865f longitude:-0.118092f];
    NSLog(@"    horizontal accuracy f(%f)",newLocation.horizontalAccuracy);
    
    
    if (![self isLocation:newLocation inRangeWith:self.currentLocation] || !self.currentLocation) {
        self.currentLocation = newLocation;
        
        [self onLocationUpdated];
    }
#endif
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation   *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"LocationLogger didUpdateToLocation lat(%f) lon(%f)",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
#if TARGET_OS_SIMULATOR
    // if we're running in the simulator we automatically fallback to London coordinates
    newLocation = [[CLLocation alloc] initWithLatitude:51.509865f longitude:-0.118092f];
    NSLog(@"    horizontal accuracy f(%f)",newLocation.horizontalAccuracy);
#endif
    
    if (![self isLocation:newLocation inRangeWith:self.currentLocation] || !self.currentLocation) {
        self.currentLocation = newLocation;
        
        [self onLocationUpdated];
    }
}

-(void)onLocationUpdated {
    NSLog(@"LocationLogger onLocationUpdated");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onLocationUpdated" object:nil];
}

/** compare two locations, but with a margin
 */
-(BOOL)isLocation:(CLLocation*)location inRangeWith:(CLLocation*)otherLocation {
    CLLocationDistance delta = [location distanceFromLocation:otherLocation];
    return (delta <= location.horizontalAccuracy); // changed to "<=" from "<" because the location can be identical
}

@end

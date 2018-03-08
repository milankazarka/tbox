//
//  LocationLogger.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

/** receiving & broadcasting location update - I usually go down the path of a pretty decentralized approach where you have objects updating asynchroniously and you have listeners
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationLogger : NSObject <CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *currentLocation;

+(LocationLogger*)shared;

@end

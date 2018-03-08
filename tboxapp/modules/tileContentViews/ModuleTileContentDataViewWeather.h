//
//  ModuleTileContentDataViewWeather.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentData.h"

@interface ModuleTileContentDataViewWeather : ModuleTileContentData

@property (weak,nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak,nonatomic) IBOutlet UILabel *locationLabel;
@property (weak,nonatomic) IBOutlet UILabel *temperatureLabel;

@end

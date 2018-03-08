//
//  ModuleViews.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleViews.h"
#import "WeatherModule.h"
#import "NewsModule.h"
#import "SportModule.h"
#import "PhotosModule.h"
#import "ClothesModule.h"
#import "TasksModule.h"

@implementation ModuleViews

+(ModuleTileContentData*)tileContentDataViewForModule:(Module*)module {
    if (!module)
        return nil;
    if ([module isKindOfClass:[WeatherModule class]])
        return [[[NSBundle mainBundle] loadNibNamed:@"TileContentDataViewWeather" owner:self options:nil] objectAtIndex:0];
    else if ([module isKindOfClass:[NewsModule class]])
        return [[[NSBundle mainBundle] loadNibNamed:@"TileContentDataViewNews" owner:self options:nil] objectAtIndex:0];
    else if ([module isKindOfClass:[SportModule class]])
        return [[[NSBundle mainBundle] loadNibNamed:@"TileContentDataViewSport" owner:self options:nil] objectAtIndex:0];
    else if ([module isKindOfClass:[PhotosModule class]])
        return [[[NSBundle mainBundle] loadNibNamed:@"TileContentDataViewPhotos" owner:self options:nil] objectAtIndex:0];
    else if ([module isKindOfClass:[ClothesModule class]])
        return [[[NSBundle mainBundle] loadNibNamed:@"TileContentDataViewClothes" owner:self options:nil] objectAtIndex:0];
    else if ([module isKindOfClass:[TasksModule class]])
        return [[[NSBundle mainBundle] loadNibNamed:@"TileContentDataViewTasks" owner:self options:nil] objectAtIndex:0];
        
    return nil;
}

@end

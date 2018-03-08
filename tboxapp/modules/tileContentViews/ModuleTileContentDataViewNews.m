//
//  ModuleTileContentDataViewNews.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentDataViewNews.h"
#import "NewsModule.h"

@implementation ModuleTileContentDataViewNews

-(void)setModule:(Module *)module {
    _module = module;
    if (_module) {
        if ([_module isKindOfClass:[NewsModule class]]) {
            NewsModule *nm = (NewsModule*)_module;
            if (nm.items.count>0) {
                self.headlineLabel.text = [nm.items objectAtIndex:0].title;
                self.descLabel.text = [nm.items objectAtIndex:0].summary;
            }
        }
    }
}

@end

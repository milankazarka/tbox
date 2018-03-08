//
//  ModuleTile.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTile.h"
#import "Module.h"
#import "ModuleTileContentData.h"
#import "ModuleViews.h"

@interface ModuleTile () <ModuleDelegate>
@property (strong,nonatomic) ModuleTileContentData *contentDataView;
@end

@implementation ModuleTile 

-(void)didMoveToSuperview {
    self.contentDataView = nil;
    self.alpha = 0.9f;
    self.layer.cornerRadius = 7.0f;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    [self loadContentView];
    if (self.module)
        [self loadModule:self.module];
}

-(void)loadContentView {
    self.content = [[[NSBundle mainBundle] loadNibNamed:@"ModuleTileContent" owner:self options:nil] objectAtIndex:0];
    self.content.frame = self.contentView.bounds;
    [self.contentView addSubview:self.content];
}

-(void)setModule:(Module *)module {
    _module = module;
    if (_module)
        [self loadModule:_module];
}

-(void)setContentDataView:(ModuleTileContentData *)contentDataView {
    _contentDataView = contentDataView;
    if (!_contentDataView)
        return;
    if (self.content) {
        _contentDataView.frame = self.content.bounds;
        [self.content addSubview:_contentDataView];
        _contentDataView.module = _module;
    }
}

-(void)loadModule:(Module *)module {
    self.content.titleLabel.text = _module.name;
    if (self.contentDataView)
        [self.contentDataView removeFromSuperview];
    ModuleTileContentData *contentDataView = [ModuleViews tileContentDataViewForModule:_module];
    self.contentDataView = contentDataView;
}

-(void)onModuleUpdate:(Module*)module {
    if (_contentDataView)
        _contentDataView.module = module;
}

@end

//
//  ModuleTileContentDataViewPhotos.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentDataViewPhotos.h"
#import "PhotosModule.h"

@implementation ModuleTileContentDataViewPhotos

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.previews = nil;
    }
    return self;
}

-(void)setModule:(Module *)module {
    _module = module;
    if (_module) {
        if ([_module isKindOfClass:[PhotosModule class]]) {
            [self tryLoadingPreviewAtIndex:0 uiv:self.prev1];
            [self tryLoadingPreviewAtIndex:1 uiv:self.prev2];
            [self tryLoadingPreviewAtIndex:2 uiv:self.prev3];
            [self tryLoadingPreviewAtIndex:3 uiv:self.prev4];
        }
    }
}

-(void)tryLoadingPreviewAtIndex:(NSUInteger)index uiv:(UIImageView*)uiv {
    
    // #todo - data should actually come from the module
    
    NSString* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString* foofile = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"picked%d.png",index]];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    if (fileExists) {
        uiv.image = [UIImage imageWithContentsOfFile:foofile];
    }
}

-(void)update {
    //
}

-(void)didMoveToSuperview {
    self.previews = [[NSMutableArray alloc] initWithCapacity:4];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self update];
}

@end

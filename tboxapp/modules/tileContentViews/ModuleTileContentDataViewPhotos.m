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
        self.previews = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setModule:(Module *)module {
    _module = module;
    if (_module) {
        if ([_module isKindOfClass:[PhotosModule class]]) {
            
            [self.previews removeAllObjects];
            // should be a collection
            [self.previews addObject:self.prev1];
            [self.previews addObject:self.prev2];
            [self.previews addObject:self.prev3];
            [self.previews addObject:self.prev4];
            
            PhotosModule *pm = (PhotosModule*)_module;
            NSMutableArray *previews = [pm previewImages];
            for(int n = 0; n < previews.count; n++) {
                if (n>3)
                    break;
                UIImageView *iv = [self.previews objectAtIndex:n];
                iv.image = [previews objectAtIndex:n];
            }
            NSLog(@"");
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

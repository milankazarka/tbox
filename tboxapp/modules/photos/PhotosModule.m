//
//  PhotosModule.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "PhotosModule.h"

@implementation PhotosModule

-(id)init {
    self = [super init];
    if (self) {
        self.name = @"Photos";
        
        NSData *photosStoredData = [[NSUserDefaults standardUserDefaults] objectForKey:@"photos"];
        if (!photosStoredData)
            [self createStorage];
    }
    return self;
}

-(NSString*)pathForImageFilename:(NSString*)filename {
    // todo - determines the documents path too often
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
}

-(NSMutableDictionary*)createStorage {
    NSDictionary *dict = [[NSDictionary alloc] init];
    
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"photos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return [[NSMutableDictionary alloc] initWithDictionary:dict];
}

-(BOOL)storeImage:(UIImage*)image atCellIndex:(NSUInteger)index {
    if (!image)
        return NO;
    
    NSString *filename = [NSString stringWithFormat:@"picked%lu.png",(unsigned long)index];
    NSString *filePath = [self pathForImageFilename:filename];
    
    // Save image.
    if (![UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
        NSLog(@"couldn't store - show error");
    }
    
    // we do a check again in case
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!fileExists) {
        // sometimes it behaves funny when the storage is up - #todo - some more error checks
        NSLog(@"couldn't store - show error");
    }
    
    NSMutableDictionary *mutableStored = nil;
    NSData *photosStoredData = [[NSUserDefaults standardUserDefaults] objectForKey:@"photos"];
    if (photosStoredData) {
        NSDictionary *photosStored = [NSKeyedUnarchiver unarchiveObjectWithData:photosStoredData];
        mutableStored = [[NSMutableDictionary alloc] initWithDictionary:photosStored];
    }
    
    [mutableStored setObject:filename forKey:[NSNumber numberWithUnsignedInteger:index]];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:mutableStored];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"photos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

-(UIImage*)imageAtCellIndex:(NSUInteger)index {
    
    NSData *photosStoredData = [[NSUserDefaults standardUserDefaults] objectForKey:@"photos"];
    if (photosStoredData) {
        NSDictionary *photosStored = [NSKeyedUnarchiver unarchiveObjectWithData:photosStoredData];
        NSString *filename = [photosStored objectForKey:[NSNumber numberWithUnsignedInteger:index]];
        if (filename) {
            
            NSString *filePath = [self pathForImageFilename:filename];
            
            return [UIImage imageWithContentsOfFile:filePath];
        }
    }
    
    return nil;
}

-(NSMutableArray*)previewImages {
    // #todo - ideally wouldn work with the local variable, not always recreate
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSData *photosStoredData = [[NSUserDefaults standardUserDefaults] objectForKey:@"photos"];
    if (photosStoredData) {
        NSDictionary *photosStored = [NSKeyedUnarchiver unarchiveObjectWithData:photosStoredData];
        for(NSString *key in photosStored.allKeys) {
            NSString *filename = [photosStored objectForKey:key];
            if (filename) {
                
                NSString *filePath = [self pathForImageFilename:filename];
                
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (image)
                    [array addObject:image];
            }
        }
    }
    return array;
}

@end

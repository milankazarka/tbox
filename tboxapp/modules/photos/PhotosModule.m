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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"picked%lu.png",(unsigned long)index]];
    
    // Save image.
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    
    NSMutableDictionary *mutableStored = nil;
    NSData *photosStoredData = [[NSUserDefaults standardUserDefaults] objectForKey:@"photos"];
    if (photosStoredData) {
        NSDictionary *photosStored = [NSKeyedUnarchiver unarchiveObjectWithData:photosStoredData];
        mutableStored = [[NSMutableDictionary alloc] initWithDictionary:photosStored];
    }
    
    [mutableStored setObject:filePath forKey:[NSNumber numberWithUnsignedInteger:index]];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:mutableStored];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"photos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

-(UIImage*)imageAtCellIndex:(NSUInteger)index {
    
    NSData *photosStoredData = [[NSUserDefaults standardUserDefaults] objectForKey:@"photos"];
    if (photosStoredData) {
        NSDictionary *photosStored = [NSKeyedUnarchiver unarchiveObjectWithData:photosStoredData];
        NSString *path = [photosStored objectForKey:[NSNumber numberWithUnsignedInteger:index]];
        if (path)
            return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}

@end

//
//  SportModule.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "SportModule.h"
#import "NetworkRequest.h"
#import "Common.h"

@implementation SportModule

-(id)init {
    self = [super init];
    if (self) {
        self.name = @"Sport";
        
        // don't handle updating or initial nil value
        
        self.entries = [[NSMutableArray alloc] init];
        [self update];
    }
    return self;
}

-(void)update {
    NSLog(@"SportModule update");
    
    [self.entries removeAllObjects];
    
    [NetworkRequest apiRequestWithCompleteURL:_SPORTDATA_URL completion:^(id data) {
        if (data) {
            NSLog(@"SportModule update; got data");
            if ([data isKindOfClass:[NSData class]]) {
            
                NSString* newStr = [NSString stringWithUTF8String:[data bytes]];
                NSUInteger index = 0;
                NSArray* rows = [newStr componentsSeparatedByString:@"\n"];
                NSArray *keys = nil;
                for (NSString *row in rows){
                    NSArray* columns = [row componentsSeparatedByString:@","];
                    if (index==0) {
                        keys = columns;
                    } else {
                        NSMutableDictionary *lineDict = [[NSMutableDictionary alloc] init];
                        for(int n = 0; n < [columns count]; n++) {
                            [lineDict setObject:[columns objectAtIndex:n] forKey:[keys objectAtIndex:n]];
                        }
                        [self.entries addObject:lineDict];
                    }
                    index++;
                }
                NSLog(@"    have basic data");
            }
        }
    }];
}

@end

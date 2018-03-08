//
//  ClothesModule.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ClothesModule.h"
#import "NetworkRequest.h"
#import "Common.h"

@implementation ClothesModule

-(id)init {
    self = [super init];
    if (self) {
        self.clothesTypes = [[NSMutableDictionary alloc] init];
        self.name = @"Clothes";
        [self update];
    }
    return self;
}

-(void)update {
    // #todo - needs update, some parts deprecated
    [NetworkRequest apiRequestWithCompleteURL:_CLOTHES_URL completion:^(id data) {
        if (data) {
            NSLog(@"ClothesModule update; got data");
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSArray *payloadArray = [data objectForKey:@"payload"];
                if (payloadArray) {
                    for(NSDictionary *item in payloadArray) {
                        NSString *clothe = [item objectForKey:@"clothe"];
                        NSNumber *amount = [self.clothesTypes objectForKey:clothe];
                        if (!amount)
                            amount = @0;
                        NSUInteger namount = [amount unsignedIntegerValue]; // todo, duplicate if nil before
                        namount++;
                        amount = [NSNumber numberWithUnsignedInteger:namount];
                        [self.clothesTypes setValue:amount forKey:clothe];
                    }
                    NSLog(@"    clothes counted");
                    [self onModuleUpdate];
                }
            }
        }
    }];
}

@end

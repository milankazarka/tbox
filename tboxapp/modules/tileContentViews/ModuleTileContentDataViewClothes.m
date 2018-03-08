//
//  ModuleTileContentDataViewClothes.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentDataViewClothes.h"
#import "XYPieChart.h"
#import "ClothesModule.h"

@interface ModuleTileContentDataViewClothes () <XYPieChartDelegate,XYPieChartDataSource>

@property (strong,nonatomic) XYPieChart *chart;
@property (assign,nonatomic) NSUInteger sum;

@end

@implementation ModuleTileContentDataViewClothes

-(void)setModule:(Module *)module {
    _module = module;
    if (_module) {
        if ([_module isKindOfClass:[ClothesModule class]]) {
            self.chart = [[XYPieChart alloc] initWithFrame:self.graphHolder.bounds];
            [self.graphHolder addSubview:self.chart];
            [self.chart setDelegate:self];
            [self.chart setDataSource:self];
            [self.chart reloadData];
            [self.chart setShowPercentage:YES];	//optional
        }
    }
}

-(NSUInteger)sum {
    // #todo - not to be always calculated
    _sum = 0;
    for(NSString *key in ((ClothesModule*)_module).clothesTypes.allKeys) {
        NSNumber *current = [((ClothesModule*)_module).clothesTypes objectForKey:key];
        _sum+=[current unsignedIntegerValue];
    }
    return _sum;
}

-(NSNumber*)clotheTypeAtIndex:(NSUInteger)index {
    NSUInteger count = 0;
    for(NSString *key in ((ClothesModule*)_module).clothesTypes.allKeys) {
        if (count==index)
            return [((ClothesModule*)_module).clothesTypes objectForKey:key];
        count++;
    }
    return nil;
}

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
    NSUInteger keysNum = ((ClothesModule*)_module).clothesTypes.allKeys.count;
    return keysNum;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
    NSNumber *clothTypeVal = [self clotheTypeAtIndex:index];
    if (clothTypeVal) {
        CGFloat val = (CGFloat)([clothTypeVal floatValue]/(CGFloat)self.sum);
        return val;
    }
    return 0.0f;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index {
    return [UIColor colorWithRed:0.1f*(CGFloat)index green:0.5f blue:1.0f-(0.1f*(CGFloat)index) alpha:1.0f];
    // [UIColor colorWithWhite:0.1f*(CGFloat)index alpha:1.0f];
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index {
    NSUInteger count = 0;
    for(NSString *key in ((ClothesModule*)_module).clothesTypes.allKeys) {
        if (count==index)
            return key;
        count++;
    }
    return @"";
}

@end

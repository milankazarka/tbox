//
//  ModuleTileContentDataViewSport.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "ModuleTileContentDataViewSport.h"
#import "SportModule.h"

@implementation ModuleTileContentDataViewSport

-(void)setModule:(Module *)module {
    _module = module;
    if (_module) {
        if ([_module isKindOfClass:[SportModule class]]) {
            SportModule *sm = (SportModule*)_module;
            if (sm.entries.count>0) {
                self.teamsLabel.text = [NSString stringWithFormat:@"%@ vs %@",
                                        [[sm.entries objectAtIndex:0] objectForKey:@"HomeTeam"],
                                        [[sm.entries objectAtIndex:0] objectForKey:@"AwayTeam"]
                                        ];
                NSString *result = [[sm.entries objectAtIndex:0] objectForKey:@"FTR"];
                NSString *whoWon = nil;
                if ([result isEqualToString:@"H"]) {
                    whoWon = [[sm.entries objectAtIndex:0] objectForKey:@"HomeTeam"];
                } else if ([result isEqualToString:@"A"]) {
                    whoWon = [[sm.entries objectAtIndex:0] objectForKey:@"AwayTeam"];
                }
                if (whoWon)
                    self.resultLabel.text = [NSString stringWithFormat:@"%@ won",whoWon];
                else
                    self.resultLabel.text = @"draw";
            }
        }
    }
}

@end

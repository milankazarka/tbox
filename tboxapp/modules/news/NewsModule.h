//
//  NewsModule.h
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "Module.h"
#import <MWFeedParser/MWFeedParser.h>

@interface NewsModule : Module

@property (strong,nonatomic) NSMutableArray<MWFeedItem*> *items;

@end

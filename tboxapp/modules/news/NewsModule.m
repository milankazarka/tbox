//
//  NewsModule.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "NewsModule.h"

@interface NewsModule () <MWFeedParserDelegate>

@end

@implementation NewsModule

-(id)init {
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
        self.name = @"News";
        [self update];
    }
    return self;
}

-(void)update {
    NSLog(@"NewsModule update");
    [self.items removeAllObjects];
    NSURL *feedURL = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/rss.xml"];
    MWFeedParser *feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
    NSLog(@"    ready");
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"    item");
    [self.items addObject:item];
}

-(void)feedParserDidFinish:(MWFeedParser *)parser {
    [self onModuleUpdate];
}

@end

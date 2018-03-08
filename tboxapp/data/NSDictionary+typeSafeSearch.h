//
//  NSDictionary+typeSafeSearch.h
//  snooopitPrototyping
//
//  Created by Milan Kazarka on 8/15/17.
//  Copyright © 2017 Milan Kazarka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_typeSafeSearch)

-(id)objectForKey:(id)key typeClass:(Class)classType;
// if the DOM path would be meta->bias->time_of_day where as the time_of day is an array use:
//      NSArray *time_of_day = [self.rawData objectAtPath:@[[NSDictionary class],@"meta"],@[[NSDictionary class],@"bias"],@[[NSArray class],@"time_of_day"], nil];
-(id)objectAtPath:(NSArray *)rootNode,... NS_REQUIRES_NIL_TERMINATION; // fetch an object at DOM path

@end

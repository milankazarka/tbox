//
//  NSDictionary+typeSafeSearch.m
//  snooopitPrototyping
//
//  Created by Milan Kazarka on 8/15/17.
//  Copyright © 2017 Milan Kazarka. All rights reserved.
//

#import "NSDictionary+typeSafeSearch.h"

@implementation NSDictionary (NSDictionary_typeSafeSearch)

-(id)objectForKey:(id)key typeClass:(Class)classType {
    id object = [self objectForKey:key];
    if (object) {
        if ([object isKindOfClass:classType]) {
            return object;
        }
    }
    return nil;
}

/** a helper method to digg up objects in a DOM tree where we pass the list of the branches
 */
-(id)objectAtPath:(NSArray*)rootNode,... {
    if (!rootNode)
        return nil;

    NSMutableArray *path = [[NSMutableArray alloc] init];
    
    va_list args;
    va_start(args, rootNode);
    for (NSArray *arg = rootNode; arg != nil; arg = va_arg(args, NSArray*)) {
        if ([arg count]==2) {
            [path addObject:arg];
        }
    }
    
    return [self itteratePath:path currentIndex:0 currentNode:self];
}

-(id)itteratePath:(NSMutableArray*)path currentIndex:(int)index currentNode:(id)node {
    
    if (![node isKindOfClass:[NSDictionary class]])
        return nil;
    NSDictionary *dictNode = (NSDictionary*)node;
    
    NSArray *nodeDef = [path objectAtIndex:index];
    id nextNode = [dictNode objectForKey:[nodeDef objectAtIndex:1]];
    if (!nextNode)
        return nil;
    if (![nextNode isKindOfClass:[nodeDef objectAtIndex:0]])
        return nil;
    index++;
    if (index==[path count])
        return nextNode;
    return [self itteratePath:path currentIndex:index currentNode:nextNode];
}

@end

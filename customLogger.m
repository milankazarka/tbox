//
//  customLogger.m
//  mangoartAdminTest
//
//  Created by Milan Kazarka on 6/29/17.
//  Copyright © 2017 Milan Kazarka. All rights reserved.
//

#import "customLogger.h"

void customLogger(NSString *format, ...) {
    
#ifndef _DEBUG
    return;
#endif
    
    va_list argumentList;
    va_start(argumentList, format);
    NSMutableString * message = [[NSMutableString alloc] initWithFormat:format
                                                              arguments:argumentList];
    
    NSLogv(message, argumentList); // Originally NSLog is a wrapper around NSLogv.
    va_end(argumentList);
}

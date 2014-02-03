//
//  utilities.m
//  operatorMIDI
//
//  Created by Pablo on 24/12/2013.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "utilities.h"


@implementation utilities

+(void)notify:(int)type {
    [self notifyWithData:type:nil];
}

+(void)notifyWithData:(int)type :(NSDictionary*)data {
    NSString* typeAsString = [NSString new];
    switch(type) {
        case 0:
            typeAsString = @"controlChange";
        break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:typeAsString object:self userInfo: data];
}

@end

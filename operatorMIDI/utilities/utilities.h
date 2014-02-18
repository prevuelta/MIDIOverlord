//
//  utilities.h
//  operatorMIDI
//
//  Created by Pablo on 24/12/2013.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface utilities : NSObject

+(void)notify:(int)type;
+(void)notifyWithData:(int)type :(NSArray*)data;

+(NSColor*)getNSColorFromRGB:(float[])colors;


@end

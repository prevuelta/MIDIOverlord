//
//  global.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "utilities.h"

@interface global : NSObject

@property NSImage *patternBg;

@property NSColor *blackColor;
@property NSColor *defaultColor;
@property NSColor *bgColor;
@property NSColor *markerColor;
@property NSColor *activeColor;

+(global*)sharedGlobalData;

@end



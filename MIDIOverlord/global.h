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

@property NSColor *black;
@property NSColor *darkestGrey;
@property NSColor *darkBrown;
@property NSColor *brown;

@property NSColor *defaultColor;
@property NSColor *bgColor;
@property NSColor *markerColor;
@property NSColor *activeColor;

@property NSMutableDictionary *colors;

@property NSCharacterSet *invalidChars;
@property NSCharacterSet *notNumbers;

@property NSMutableDictionary* midiDestinations;
@property int midiDestinationCount;

+(global*)sharedGlobalData;
+(void)deselectNotify;
+(void)stopRecordingNotify;
+(NSString *)uuid;
+(int)getUnitWidth:(int)units;

@end



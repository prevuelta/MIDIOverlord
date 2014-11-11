//
//  controlDial.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@interface controlDial : controlBase

@property NSNumber *value;

@property NSColor *defaultColor;
@property NSColor *highlightColor;
@property NSColor *markerColor;

@property int max;
@property int min;
@property int range;
@property int marker;
@property int size;

@property BOOL relative;

@property NSPoint initialPoint;

-(id)initWithSize:(int)size andValue: (NSNumber*)value;
-(id)initWithSize:(int)size andValue: (NSNumber*)value andMinValue: (int)min andMaxValue: (int)max;

-(void)updateControlFromEvent:(NSEvent*)e;
-(void)updateControlFromData:(NSNumber*)value;

@end

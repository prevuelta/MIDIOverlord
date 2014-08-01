//
//  controlSlider.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "uiTextField.h"

@interface controlSlider : controlBase

@property NSNumber* value;
@property int max;
@property int min;
@property int range;
@property int marker;

@property NSPoint size;
@property NSTrackingArea *trackRect;

@property uiTextField *textVal;
@property uiTextField *label;

@property NSColor *defaultColor;
@property NSColor *markerColor;

-(id)initWithSize:(NSPoint)size andValue: (NSNumber*)value andMinValue:(int)min andMaxValue:(int)max;

-(void)updateControlFromEvent:(NSEvent*)e;
-(void)updateControlFromData:(NSNumber*)value;

@end

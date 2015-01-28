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

@property NSSize size;
@property NSTrackingArea *trackRect;

@property uiTextField *textVal;
@property uiTextField *label;

@property NSColor *defaultColor;
@property NSColor *highlightColor;
@property NSColor *markerColor;

@property BOOL isVertical;

-(id)initWithSize:(NSSize)size andValue: (NSNumber*)value andMinValue:(int)min andMaxValue:(int)max andIsVertical:(BOOL)isVertical;

-(void)updateControlFromEvent:(NSEvent*)e;
-(void)updateControlFromData:(NSNumber*)value;

@end

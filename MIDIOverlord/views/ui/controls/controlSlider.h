//
//  controlSlider.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "uiText.h"

@interface controlSlider : controlBase

@property NSNumber* value;
@property int max;
@property int min;
@property int range;
@property int marker;

@property NSPoint size;
@property NSPoint offset;

@property uiText *textVal;
@property uiText *label;

-(id)initWithFrame:(NSPoint)size :(NSPoint)offset :(int)min :(int)max;

-(void)updateControlFromEvent:(NSEvent*)e;
-(void)updateControlFromData:(NSNumber*)value;

@end

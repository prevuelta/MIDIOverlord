//
//  controlSlider.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@interface controlSlider : controlBase

@property (nonatomic) int value;
@property int max;
@property int min;
@property int range;
@property int marker;

@property NSPoint size;
@property NSPoint offset;

@property NSTextField *textVal;

-(id)initWithFrame:(NSPoint)size :(NSPoint)offset :(NSColor*)sliderBg :(int)min :(int)max;
-(void)updateControlFromEvent:(NSEvent*)e;

@end

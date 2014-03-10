//
//  controlSlider.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@interface controlSlider : controlBase

@property int value;
@property int max;
@property int min;

@property NSPoint size;
@property NSPoint offset;

-(id)initWithFrame:(NSRect)frame :(NSPoint)size :(NSPoint)offset :(int)min :(int)max;

@end

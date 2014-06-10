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

@property (nonatomic) int value;
@property int max;
@property int min;
@property int range;
@property int marker;

@property NSPoint size;
@property NSPoint offset;

@property controlText *textVal;

-(id)initWithFrame:(NSPoint)size :(NSPoint)offset :(int)min :(int)max;
-(void)updateControlFromEvent:(NSEvent*)e;

@end

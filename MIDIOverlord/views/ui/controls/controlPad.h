//
//  gmUIElement.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "controlBase.h"
#import "controlText.h"

@interface controlPad : controlBase

@property NSNumber* value;
@property int max;
@property int min;
@property int range;

@property NSPoint size;

-(id)initWithSize:(NSPoint)size andValue: (NSNumber*)value andMinValue:(int)min andMaxValue:(int)max;

@end

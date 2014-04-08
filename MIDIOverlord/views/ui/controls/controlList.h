//
//  controlList.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@interface controlList : controlBase

@property int width;

-(id)initWithFrame: (NSMutableArray*)keyValues andLabel:(NSString*)labelText andDefault:(NSString*)defaultText;

@property NSMutableArray *selected;
@property int height;
@property BOOL state;

@property NSColor* bgColor;
@property NSColor* activeBgColor;
@property NSColor* fgColor;

@end

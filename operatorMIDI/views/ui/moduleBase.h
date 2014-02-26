//
//  moduleBase.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "controlTrigger.h"
#import "utilities.h"

@interface moduleBase : NSView <controlBaseDelegate>

//Data
@property NSDictionary* elData;

// Canvas properties
@property int padding;
@property int width;
@property int gridX;
@property int gridY;

// UI

@property NSTextField* label;

-(id)initWithFrame:(NSRect)frame;
-(void)setOrigin:(NSPoint)origin;
-(void)mouseDown:(NSEvent *)theEvent;
-(void)setControlLabel:(NSRect)frame:(NSString*)text;

@end

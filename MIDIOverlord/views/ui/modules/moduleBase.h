//
//  moduleBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "controlTrigger.h"
#import "controlText.h"
#import "controlSlider.h"
#import "controlList.h"
#import "uiLabel.h"
#import "utilities.h"

@interface moduleBase : NSView <controlBaseDelegate>

//Data
@property NSDictionary* elData;

// Canvas properties
@property int padding;
@property int width;
@property int height;
@property int gridX;
@property int gridY;

// Midi properties
@property int midiValue;


// Display options
@property int displayPanel; // 0: main, 1: input, 2: output

// UI
@property uiLabel *label;
@property NSString *labelText;
@property NSColor *bgColor;

-(id)initWithFrame:(NSRect)frame;
-(void)setOrigin:(NSPoint)origin;
-(void)mouseDown:(NSEvent *)theEvent;
-(void)drawRect:(NSRect)rect;
-(void)drawBg:(NSRect)rect;
-(void)drawModule:(NSRect)rect;

@end

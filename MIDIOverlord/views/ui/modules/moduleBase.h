//
//  moduleBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "uiBase.h"

#import "controlTrigger.h"
#import "controlSlider.h"
#import "controlList.h"

#import "deviceList.h"
#import "uiText.h"
#import "utilities.h"

@class moduleBase;

@protocol moduleBaseDelegate
-(void)midiData:(NSDictionary*)data;
@end

@interface moduleBase : uiBase

//Data
@property NSDictionary* data;

@property (nonatomic, assign) id delegate;

// Canvas properties
@property int width;
@property int height;
@property int gridX;
@property int gridY;

// Midi properties
@property int midiV1;
@property int midiV2;
@property int midiV3;

// Display options
@property NSInteger tag;

// UI
@property uiText *label;
@property NSString *labelText;

-(id)initWithFrame:(NSRect)frame;
-(void)mouseDown:(NSEvent *)theEvent;
-(void)drawRect:(NSRect)rect;
-(void)drawBg:(NSRect)rect;
-(void)drawModule:(NSRect)rect;
-(void)addCCField;

@end

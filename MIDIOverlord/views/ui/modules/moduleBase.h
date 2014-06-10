//
//  moduleBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "controlTrigger.h"
#import "uiText.h"
#import "controlSlider.h"
#import "controlList.h"
#import "deviceList.h"
#import "uiLabel.h"
#import "utilities.h"

@class moduleBase;

@protocol moduleBaseDelegate
-(void)midiData:(NSDictionary*)data;
@end

@interface moduleBase : NSView

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
@property BOOL selected;
@property NSInteger tag;

// UI
@property controlText *label;
@property NSString *labelText;

@property NSColor *bgColor;
@property NSColor *selectedColor;

-(id)initWithFrame:(NSRect)frame;
-(void)setOrigin:(NSPoint)origin;
-(void)mouseDown:(NSEvent *)theEvent;
-(void)drawRect:(NSRect)rect;
-(void)drawBg:(NSRect)rect;
-(void)drawModule:(NSRect)rect;
-(void)addCCField;

-(void)deselect:(NSNotification*)notification ;

@end

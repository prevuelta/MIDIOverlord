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
-(void)midiData:(NSArray*)data;
-(void)moduleUpdateWithData: (NSDictionary*)data;
@end

@interface moduleBase : uiBase

//Data
@property NSMutableDictionary* data;

@property (nonatomic, assign) id delegate;

// Canvas properties
@property int width;
@property int height;
@property int gridX;
@property int gridY;

// Midi properties
@property NSNumber *midiV1;
@property NSNumber *midiV2;
@property NSNumber *midiV3;

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
-(void)updateModel;

@end

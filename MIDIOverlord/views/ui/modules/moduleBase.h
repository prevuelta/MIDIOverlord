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
#import "controlText.h"
#import "uiText.h"
#import "uiEditText.h"
#import "utilities.h"
#import "uiButton.h"
#import "uiButtonClose.h"

@class moduleBase;

@protocol moduleBaseDelegate
-(void)midiData:(NSArray*)data;
-(void)moduleUpdateWithData: (NSDictionary*)data;
@end

@interface moduleBase : uiBase

@property (nonatomic, assign) id delegate;

//Data
@property NSMutableDictionary* data;

// Edit mode
@property BOOL editMode;

// Canvas properties
@property int width;
@property int height;
@property int gridX;
@property int gridY;

// Midi properties
@property NSNumber *midiStatusByte;
@property NSNumber *midiByte1;
@property NSNumber *midiByte2;

// Display options
@property NSInteger tag;

// UI
@property uiText *label;


// Methods
-(id)initWithFrame:(NSRect)frame;
-(void)mouseDown:(NSEvent *)theEvent;
-(void)drawRect:(NSRect)rect;
-(void)drawBg:(NSRect)rect;
-(void)drawModule:(NSRect)rect;
-(void)addCCField;
-(void)updateModel;
-(void)handleEditMode:(NSNotification*)notification;

@end

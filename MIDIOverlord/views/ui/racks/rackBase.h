//
//  rackBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleBase.h"
#import "deviceList.h"
#import "controlText.h"

@interface rackBase : NSView <moduleBaseDelegate>

@property (nonatomic, assign) id delegate;

@property NSDictionary* data;
@property NSMutableArray* subViews;
@property int headerHeight;

@property deviceList *midiInput;
@property deviceList *midiOutput;

@property int deviceIn;
@property int deviceOut;

@property controlText *midiChannelText;
@property int midiChannel;


// Canvas properties
@property int width;
@property int height;
//@property int gridX;
//@property int gridY;

// Midi properties
//@property int midiV1;
//@property int midiV2;
//@property int midiV3;

// Display options
@property BOOL selected;
@property NSInteger tag;

// UI
@property controlText *label;
@property NSString *labelText;

@property NSColor *bgColor;
@property NSColor *selectedColor;

@property NSColor *blackColor;
@property NSColor *defaultColor;
@property NSColor *markerColor;
@property NSColor *activeColor;

// Notifications
//@property NSNotificationCenter* center;

-(void)addRackTitle;
-(void)createMidiDestinationsDeviceList:(NSNotification*)notification;

// Util functions
-(void)setOrigin:(NSPoint)origin;
-(void)mouseDown:(NSEvent *)theEvent;


@end

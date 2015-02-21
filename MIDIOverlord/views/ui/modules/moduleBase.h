//
//  moduleBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MIKMIDI/MIKMIDI.h>

#import "uiBase.h"

#import "controlTrigger.h"
#import "controlSlider.h"
#import "controlDial.h"
#import "controlList.h"
#import "controlText.h"
#import "uiTextField.h"
#import "uiNoteField.h"
#import "uiEditableTextField.h"
#import "utilities.h"
#import "uiButton.h"

@class moduleBase;

@protocol moduleBaseDelegate
-(void)midiCommand:(NSArray*)data;
-(void)startMap:(NSDictionary*)mID;
@end

@interface moduleBase : uiBase

@property (nonatomic, assign) id delegate;

//Data
@property (weak) NSMutableDictionary* data;

// Canvas properties
@property int width;
@property int height;
@property int gridX;
@property int unitWidth;
@property int unitHeight;

// Display options
@property NSInteger tag;

/* MIDI Commands */

@property MIKMIDICommand *receiveCommand;
@property NSString *MIDIIdentifier;

/* MIDI Mapping */

@property BOOL isMapping;
@property uiButton *receiveMap;
@property uiButton *sendMap;

// UI
@property uiEditableTextField *label;

/* Init Methods */
-(id)initWithUnitWidth:(NSNumber*)unitWidth andUnitHeight:(NSNumber*)unitHeight;

-(id)initWithFrame:(NSRect)frame;

-(id)initWithData:(NSMutableDictionary*)data;

/* Midi */

-(void)handleMIDICommand:(NSNotification*)notification;

-(MIKMIDIResponderType)MIDIResponderTypeForCommandIdentifier:(NSString *)commandID;
-(NSArray*)commandIdentifiers;

/* Helpers */

-(int)getWidth;
-(int)getHeight;

@end

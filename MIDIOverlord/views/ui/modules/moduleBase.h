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
-(void)startRecord:(NSString*)MIDIIdentifier;
@end

@interface moduleBase : uiBase

@property (nonatomic, assign) id delegate;

//Data
@property NSMutableDictionary* data;

// Canvas properties
@property int width;
@property int height;
@property int gridX;
@property int gridY;

// Display options
@property NSInteger tag;

// Midi
@property MIKMIDICommand *receiveCommand;
@property NSString *MIDIIdentifier;
@property BOOL isRecording;
@property uiButton *receiveRecordBtn;

// UI
@property uiEditableTextField *label;

/* Init Methods */
-(id)initWithHeight:(int)height;

-(id)initWithSize:(NSSize)size;

-(id)initWithFrame:(NSRect)frame;

-(id)initWithData:(NSMutableDictionary*)data;

/* Midi */

-(BOOL)respondsToMIDICommand:command;
-(void)handleMIDICommand:(NSNotification*)notification;

-(MIKMIDIResponderType)MIDIResponderTypeForCommandIdentifier:(NSString *)commandID;
-(NSArray*)commandIdentifiers;

@end

//
//  rackBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <MIKMIDI/MIKMIDI.h>
#import "uiBase.h"
#import "moduleBase.h"
#import "moduleSlider.h"
#import "modulePads.h"
#import "moduleMap.h"
#import "scrollableView.h"
#import "controlList.h"
#import "uiEditableTextField.h"
#import "uiIndicator.h"

@interface rackBase : uiBase <moduleBaseDelegate>

@property (nonatomic, assign) id delegate;

@property int headerHeight;

@property NSMutableDictionary* data;
@property NSMutableArray* subViews;

@property controlList *midiSend;
@property controlList *midiReceive;

@property controlText *receiveChannel;
@property controlText *sendChannel;

@property NSNumber *rackID;

// Canvas properties
@property int width;
@property int height;

@property int unitWidth;
@property int unitHeight;

// Display
@property scrollableView *moduleView;
@property int unitSize;

// UI
@property uiEditableTextField *label;
@property NSString *labelText;

@property uiIndicator *midiIndicator;

// Modules
@property NSMutableDictionary *moduleData;

/* Midi */
@property MIKMIDISourceEndpoint *receiveDevice;
@property MIKMIDIDestinationEndpoint *sendDevice;

@property MIKMIDIMapping * mappings;

@property BOOL isMapping;

@property NSMutableDictionary *modulesInputMap;

@property NSString *currentMIDIIdentifier;

/* Notifications */

-(id)initWithFrame:(NSRect)frame andData:(NSMutableDictionary*)data;
-(void)addRackTitle;

/* Util functions */

-(void)mouseDown:(NSEvent *)theEvent;
-(void)updateModules;

-(int)getWidth;
-(int)getHeight;

/* Midi */

-(void)startMap:(NSDictionary *)mID;

@end

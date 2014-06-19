//
//  rackBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiBase.h"
#import "moduleBase.h"
#import "deviceList.h"
#import "uiEditText.h"

@interface rackBase : uiBase <moduleBaseDelegate>

@property (nonatomic, assign) id delegate;

@property NSMutableDictionary* data;
@property NSMutableArray* subViews;
@property int headerHeight;

@property deviceList *midiInput;
@property deviceList *midiOutput;

@property int deviceIn;
@property int deviceOut;

@property uiText *midiChannelText;
@property int midiChannel;

@property NSNumber *rackID;

// Canvas properties
@property int width;
@property int height;

@property int modalHeight;

// Display options
@property NSInteger tag;

// UI
@property uiEditText *label;
@property NSString *labelText;

// Modules
@property NSMutableDictionary *moduleData;

// Notifications
//@property NSNotificationCenter* center;

-(id)initWithFrame:(NSRect)frame andData:(NSMutableDictionary*)data;
-(void)addRackTitle;

// Util functions
-(void)mouseDown:(NSEvent *)theEvent;


@end

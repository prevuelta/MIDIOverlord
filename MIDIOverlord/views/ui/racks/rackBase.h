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
#import "uiText.h"

@interface rackBase : uiBase <moduleBaseDelegate>

@property (nonatomic, assign) id delegate;

@property NSDictionary* data;
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

// Display options
@property NSInteger tag;

// UI
@property uiText *label;
@property NSString *labelText;

// Notifications
//@property NSNotificationCenter* center;

-(id)initWithFrame:(NSRect)frame andData:(NSMutableDictionary*)data ;
-(void)addRackTitle;

// Util functions
-(void)mouseDown:(NSEvent *)theEvent;


@end

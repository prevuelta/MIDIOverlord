//
//  rack.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@interface moduleRack : moduleBase

@property NSDictionary* data;
@property NSMutableArray* subViews;
@property int headerWidth;

@property deviceList *midiInput;
@property deviceList *midiOutput;

@property controlText *midiChannelText;
@property int midiChannel;

// Notifications
//@property NSNotificationCenter* center;

-(void)addRackTitle;
-(void)createMidiDestinationsDeviceList:(NSNotification*)notification;


@end

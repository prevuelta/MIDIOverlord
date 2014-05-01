//
//  midiController.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>
//#import "eventHandler.h"
#import "utilities.h"

@interface midiController : NSObject

// Notifications
@property NSNotificationCenter* center;

@property MIDIDeviceListRef midiDevices;
@property MIDIClientRef appClient;
@property MIDIEndpointRef appOutput;

@property NSMutableDictionary* devices;

@property MIDIEndpointRef *endPointRefs;
@property MIDIEndpointRef *portRefs;

-(void)createVirtualDeviceWithClient;

-(MIDIPacketList*)getMidiPacket:(char*)status :(int)v2 :(int)v3;

-(void)handleNotifications:(NSNotification*)notification;
-(void)sendNote:(BOOL)on :(int)value;
-(void)sendControlChange:(int)cc :(int)value;

-(void)midiNotification:(int)status :(int)v2 :(int)v3 :(NSInteger)deviceID;
-(void)returnMidiDestinations:(NSNotification*)notification;
-(void)getMidiDestinations;
-(NSMutableArray*)getMidiSource;
-(NSString*)getDeviceName:(MIDIObjectRef)object;

@end

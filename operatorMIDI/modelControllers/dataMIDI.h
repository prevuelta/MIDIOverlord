//
//  dataMIDI.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>
#import "eventHandler.h"

@interface dataMIDI : NSObject <eventHandlerDelegate>

@property NSMutableArray* hexValues;
@property MIDIDeviceListRef midiDevices;
@property MIDIClientRef appClient;
@property MIDIEndpointRef appOutput;

-(void)getDestinations;
-(NSString*)getDisplayName:(MIDIObjectRef)object;
-(void)createVirtualDeviceWithClient;
-(void)sendNote:(int)value;
-(MIDIPacketList*)getMidiNotePacket:(BOOL)on:(int)value;

@end

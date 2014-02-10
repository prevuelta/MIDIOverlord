//
//  dataMIDI.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>

@interface dataMIDI : NSObject

@property MIDIDeviceListRef midiDevices;

@property MIDIClientRef appClient;
@property MIDIEndpointRef appOutput;

-(void)createVirtualDevice;

@end

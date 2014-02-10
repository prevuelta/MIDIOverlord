//
//  midiUtilities.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 3/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>
#import "dataMIDI.h"

@interface midiUtilities : NSObject

+(void)getDestinations;
+(NSString*)getDisplayName:(MIDIObjectRef)object;
+(void)createVirtualDeviceWithClient:(MIDIClientRef)client andOutput:(MIDIEndpointRef)output;
+(void)sendNote;

// TODO: Create MIDI source - allows other programs to receive messages
// MIDISourceCreate()

// TODO: Create outputport
// MIDIOutputPortCreate() + MIDISend


@end

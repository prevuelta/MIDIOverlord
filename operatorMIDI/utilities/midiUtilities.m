//
//  midiUtilities.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 3/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "midiUtilities.h"


@implementation midiUtilities

+(void)getDestinations {
    ItemCount destCount = MIDIGetNumberOfDestinations();
    NSLog(@"Destinationcount: %i", (int)destCount);
    for (ItemCount i = 0 ; i < destCount ; ++i) {
        
        // Grab a reference to a destination endpoint
        MIDIEndpointRef dest = MIDIGetDestination(i);
        if (dest) {
            NSLog(@"  Destination: %@", [self getDisplayName:dest]);
        }
    }
}

+(NSString*)getDisplayName:(MIDIObjectRef)object{
    // Returns the display name of a given MIDIObjectRef as an NSString
    CFStringRef name = nil;
    if (noErr != MIDIObjectGetStringProperty(object, kMIDIPropertyDisplayName, &name)) {
        return nil;
    }
    return (NSString*)CFBridgingRelease(name);
}

+(void)createVirtualDeviceWithClient:(MIDIClientRef)client andOutput:(MIDIEndpointRef)output {
    
    OSStatus result;
    
    // Create virtual source
    result = MIDISourceCreate(client, CFSTR("Op source"), &output);
    
    if(result != noErr) {
        NSLog(@"Error creating MIDI client: %s - %s",
              GetMacOSStatusErrorString(result),
              GetMacOSStatusCommentString(result));
        return;
    }
    
    //    result = MIDIClientCreate(CFSTR("Operator Midi Client"), NULL, NULL, &midiClient);
    //
    //
    //    MIDIPortRef inputPort;
    //
    //
    
    //    result = MIDIInputPortCreate(midiClient, CFSTR("Input"), NULL, NULL, &inputPort);
    //    MIDIPortRef outPort;
    
    //    MIDIClientCreate(@"Operator Client", NULL, NULL, testClient);
    //    MIDICl
    
    //    MIDIOutputPortCreate(testClient, @"Operator Output", outPort);
    
    //    MIDISourceCreate(testClient, @"Operator MIDI", outSrc);
}


+(MIDIPacketList)getMidiNoteOnPacket:(int)value {
    
    MIDIPacketList packetList;
    
    packetList.numPackets = 1;
    
    MIDIPacket* firstPacket = &packetList.packet[0];
    
    firstPacket->timeStamp = 0; // send immediately
    
    firstPacket->length = 3;
    
    // Type: note
    firstPacket->data[0] = 0x90;
    
//    char hexStr[2];
    NSString* hex = [NSString stringWithFormat:@"%x", value];
    
    NSLog(@"Hex value: %@", hex);
    
    // Note
    firstPacket->data[1] = hex;
    
    // Velocity
    firstPacket->data[2] = 127;
    
    return packetList;

}

+(void)sendNote:(float)noteValue {
    // Note on
    
    MIDIPacketList packetData = [self getMidiNoteOnPacket:124];
    
    // Note off
}

@end
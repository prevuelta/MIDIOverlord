//
//  dataMIDI.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "dataMIDI.h"


Byte packetBuffer[128];

@implementation dataMIDI

-(id)init {
    self = [super init];
    if(!self) return nil;

    [self createVirtualDeviceWithClient];
    [self getDestinations];
    
    _hexValues = [NSMutableArray new];
    
    for(int i = 0; i < 128; i++) {
        [_hexValues addObject:[NSString stringWithFormat:@"0x%02x", i]];
        
    }
    NSLog(@"Hex value: %@",_hexValues);
     return self;
}

-(void)getDestinations {
    ItemCount destCount = MIDIGetNumberOfDestinations();
    ItemCount sourceCount = MIDIGetNumberOfSources();
    NSLog(@"sources: %i", (int)sourceCount);
    NSLog(@"Destinationcount: %i", (int)destCount);
    for (ItemCount i = 0 ; i < destCount ; ++i) {
        
        // Grab a reference to a destination endpoint
        MIDIEndpointRef dest = MIDIGetDestination(i);
        if (dest) {
            NSLog(@"  Destination: %@", [self getDisplayName:dest]);
        }
    }
}

-(NSString*)getDisplayName:(MIDIObjectRef)object{
    // Returns the display name of a given MIDIObjectRef as an NSString
    CFStringRef name = nil;
    if (noErr != MIDIObjectGetStringProperty(object, kMIDIPropertyDisplayName, &name)) {
        return nil;
    }
    return (NSString*)CFBridgingRelease(name);
}

-(void)createVirtualDeviceWithClient {
    
    OSStatus result;
    
    // Create midi client
    
    MIDIClientCreate(CFSTR("Operator Midi Client"), NULL, NULL, &_appClient);
    
    
    // Create virtual source
    result = MIDISourceCreate(_appClient, CFSTR("Op source"), &_appOutput);
    
    if(result != noErr) {
        NSLog(@"Error creating MIDI client: %s - %s",
              GetMacOSStatusErrorString(result),
              GetMacOSStatusCommentString(result));
        return;
    }

}


-(MIDIPacketList*)getMidiNotePacket:(BOOL)on :(int)value {
    
    MIDIPacketList* packetList = (MIDIPacketList*)packetBuffer;
    MIDIPacket *packet;
    
    char status = on ? 0x80 : 0x90;
    
    Byte msg[3] = {status, (Byte)[_hexValues objectAtIndex:value], 0x40};
    
    packet = MIDIPacketListInit(packetList);
    packet = MIDIPacketListAdd(packetList, 1024, packet, 0, 3, msg);
    
   
    
    return packetList;
    
}

-(void)sendNote:(int)noteValue {
    NSLog(@"Send note: %d", noteValue);
   
    // Note on
    MIDIPacketList *packetList = [self getMidiNotePacket:true :noteValue];
    MIDIReceived(_appOutput, packetList);
    
    // Note off
    packetList = [self getMidiNotePacket:false :noteValue];
    MIDIReceived(_appOutput, packetList);
    
    
 
}


@end
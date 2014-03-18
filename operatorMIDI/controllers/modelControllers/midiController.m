//
//  midiController.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "midiController.h"


Byte packetBuffer[128];

@implementation midiController

-(id)init {
    self = [super init];
    if(!self) return nil;

    [self createVirtualDeviceWithClient];
    [utilities getMidiDestinations];
    
    // Setup notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotifications:) name:@"midiMessage" object:nil];
     return self;
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


-(MIDIPacketList*)getMidiPacket:(char*)status :(int)value2 :(int)value3 {
    
    MIDIPacketList* packetList = (MIDIPacketList*)packetBuffer;
    MIDIPacket *packet;
    
    Byte msg[3] = {status, (Byte)value2, (Byte)value3};
    
    packet = MIDIPacketListInit(packetList);
    packet = MIDIPacketListAdd(packetList, 1024, packet, 0, 3, msg);
    
    
    return packetList;
    
}

- (void)handleNotifications:(NSNotification*)notification {
    NSLog(@"Got notified: %@", notification);
    
    char status = [[notification.userInfo objectForKey:@"status"] charValue];
    int v2 = (int)[[notification.userInfo objectForKey:@"v2"] integerValue];
    int v3 = (int)[[notification.userInfo objectForKey:@"v3"] integerValue];
    
    [self sendMidiMessage: status: v2: v3];
    
}

-(void)sendMidiMessage: (char*)v1 :(int)v2 :(int)v3 {
    NSLog(@"Sending midi...");
    MIDIPacketList *packetList = [self getMidiPacket: v1 : v2 : v3 ];
    MIDIReceived(_appOutput, packetList);
}

// Midi beat clock - 24 times per quarter note

// clock 0xF8
// start 0xFA
// stop 0xFC
// continue 0xFB



@end
//
//  midiController.m
//  MIDIOverlord
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
    
//    [self getMidiDestinations];
    
    // Setup notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotifications:) name:@"midiMessage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotifications:) name:@"midiMessageToDevice" object:nil];
    // Receive request for destinations
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnMidiDestinations:) name:@"getMidiDestinations" object:nil];
    
    [self returnMidiDestinations];

//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.000 target:self selector:@selector(returnMidiDestinations) userInfo:nil repeats:YES];
//    
    return self;
}

-(void)createVirtualDeviceWithClient {
    
    OSStatus result;
    
    // Create midi client
    
    MIDIClientCreate(CFSTR("MIDI Overlord Client"), NULL, NULL, &_appClient);
    
    // Create virtual source
    result = MIDISourceCreate(_appClient, CFSTR("MIDI Overlord Source"), &_appOutput);
    
    if(result != noErr) {
        NSLog(@"Error creating MIDI client: %s - %s",
              GetMacOSStatusErrorString(result),
              GetMacOSStatusCommentString(result));
        return;
    }

}


-(MIDIPacketList*)getMidiPacket:(char)status :(int)value2 :(int)value3 {
    
    MIDIPacketList* packetList = (MIDIPacketList*)packetBuffer;
    MIDIPacket *packet;
    
    Byte msg[3] = {status, (Byte)value2, (Byte)value3};
    
    packet = MIDIPacketListInit(packetList);
    packet = MIDIPacketListAdd(packetList, 1024, packet, 0, 3, msg);
    
    
    return packetList;
    
}

- (void)handleNotifications:(NSNotification*)notification {
    NSLog(@"Got notified: %@", notification);
    
//    char status = [[notification.userInfo objectForKey:@"status"] charValue];
//    int v2 = (int)[[notification.userInfo objectForKey:@"v2"] integerValue];
//    int v3 = (int)[[notification.userInfo objectForKey:@"v3"] integerValue];
    
//    [self sendMidiMessage: status: v2: v3];
    
}

-(void)sendMidiMessageToDevice: (char)v1 :(int)v2 :(int)v3 :(NSArray*)device {
    
    int dIndex = (int)[[device objectAtIndex:1] integerValue];
    
    MIDIPacketList *packetList = [self getMidiPacket: v1 : v2 : v3 ];
    
    MIDISend(_portRefs[dIndex], _endPointRefs[dIndex], packetList);
}

-(void)sendMidiMessage: (char)v1 :(int)v2 :(int)v3 {
    NSLog(@"Sending midi...");
    MIDIPacketList *packetList = [self getMidiPacket: v1 : v2 : v3 ];
    MIDIReceived(_appOutput, packetList);
}

+(NSMutableArray*)getMidiSources {
    
    NSMutableArray *sources = [NSMutableArray new];
    
    ItemCount sourceCount = MIDIGetNumberOfSources();
    
    NSLog(@"sources: %i", (int)sourceCount);
    
    for (ItemCount i = 0 ; i < sourceCount ; ++i) {
        
    }
    
    return sources;
}

-(MIDIClientRef)newClient: (CFStringRef)outPortName {
    
    MIDIClientRef midiClient;
    
    MIDIClientCreate(outPortName, NULL, NULL, &midiClient);
    
    return midiClient;
}

-(void)returnMidiDestinations {
    NSLog(@"Returning destinations");
    [self getMidiDestinations];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMidiDestinations" object:self userInfo: _devices];
}

-(void)getMidiDestinations {
    
//    NSMutableArray *destinations = [NSMutableArray new];
    
    ItemCount destCount = MIDIGetNumberOfDestinations();
    
    NSLog(@"Destinationcount: %i", (int)destCount);
    
    MIDIEndpointRef endPointRefs[destCount];
    MIDIPortRef portRefs[destCount];
    
    _devices = [NSMutableDictionary new];
    
    for (ItemCount i = 0 ; i < destCount ; ++i) {
        
        // Grab a reference to a destination endpoint
        
        MIDIEndpointRef endPointRef = MIDIGetDestination(i);
        
        if (endPointRef) {
            
            NSNumber *deviceID = [NSNumber numberWithInt: [self getDeviceID: endPointRef]];
            
            NSString *deviceName = [self getDeviceName: endPointRef];
            
            MIDIPortRef outPort;
            
            CFStringRef outPortName = (__bridge CFStringRef)[deviceName stringByAppendingFormat:@"%@", deviceName];
        
            MIDIOutputPortCreate([self newClient:outPortName], outPortName, &outPort);
            
            endPointRefs[i] = endPointRef;
            portRefs[i] = outPort;
            
            NSArray *device = @[deviceName, [NSNumber numberWithInteger: i]];
            
            [_devices setObject: device forKey: deviceID];
            
        }

    }
    
    _endPointRefs = endPointRefs;
    _portRefs = portRefs;
    
}

-(NSString*)getDeviceName:(MIDIObjectRef)object{
    // Returns the display name of a given MIDIObjectRef as an NSString
    CFStringRef name = nil;
    if (noErr != MIDIObjectGetStringProperty(object, kMIDIPropertyDisplayName, &name)) {
        return nil;
    }
    return (NSString*)CFBridgingRelease(name);
}

-(int)getDeviceID:(MIDIObjectRef)object {
    int deviceID;
    if(noErr != MIDIObjectGetIntegerProperty(object, kMIDIPropertyUniqueID, &deviceID)) {
        return nil;
    }
    return deviceID;
}


-(void)midiNotification:(int)status :(int)v2 :(int)v3 :(NSInteger)deviceID {
    NSDictionary *data =@{
        @"status" : [NSNumber numberWithInt:status],
        @"v2" : [NSNumber numberWithInt:v2],
        @"v3" : [NSNumber numberWithInt:v3]
    };
    
    if(!deviceID) {
        
    } else if(deviceID == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessage" object:self userInfo: data];
    } else {
        //        [self.devices objectFm: deviceID];
    }
}

// Midi beat clock - 24 times per quarter note

// clock 0xF8
// start 0xFA
// stop 0xFC
// continue 0xFB



@end
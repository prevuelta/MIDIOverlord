//
//  midiController.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//


#import "midiController.h"

@implementation midiController

Byte packetBuffer[128];


-(id)init {
    self = [super init];
    if(!self) return nil;

    [self createVirtualDeviceWithClient];

    
    // Setup notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotifications:) name:@"midiMessage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMidiMessageToDevice:) name:@"midiMessageToDevice" object:nil];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnMidiDestinations) name:@"getUpdatedDevices" object:nil];
    // Receive request for destinations
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnMidiDestinations:) name:@"getMidiDestinations" object:nil];

    [self updateMidiDestinations];
   
    return self;
}

-(void)createVirtualDeviceWithClient {
    
    OSStatus sourceCreateResult;
    OSStatus destinationCreateResult;
    
    // Create midi client
    
    MIDIClientCreate(CFSTR("MIDI Overlord Client"), deviceChangeNotify, (__bridge void *)(self), &_appClient);
    
    // Create virtual source / destination
    sourceCreateResult = MIDISourceCreate(_appClient, CFSTR("MIDI Overlord Source"), &_appOutput);

    destinationCreateResult = MIDIDestinationCreate(_appClient, CFSTR("MIDI Overlord Destination"), inputNotify, (__bridge void *)(self), &_appInput);

}

void deviceChangeNotify (const MIDINotification  *message, void *refCon) {
     [(__bridge id) refCon updateMidiDestinations];
}

void inputNotify (const MIDIPacketList *list, void *procRef, void *srcRef) {
    NSLog(@"Incomig midi message %@", list);
//    [(__bridge id) refCon updateMidiDestinations];
}

-(MIDIPacketList*)getMidiPacket:(int)value1 :(int)value2 :(int)value3 {
    
    MIDIPacketList* packetList = (MIDIPacketList*)packetBuffer;
    MIDIPacket *packet;
    
    Byte msg[3] = {(Byte)value1, (Byte)value2, (Byte)value3};
    
    packet = MIDIPacketListInit(packetList);
    packet = MIDIPacketListAdd(packetList, 1024, packet, 0, 3, msg);
    
    return packetList;
    
}

- (void)handleNotifications:(NSNotification*)notification {
    NSLog(@"Got notified: %@", notification);
    
    NSArray *midiData = notification.userInfo[@"data"];
    
    [self sendMidiMessage: [midiData[0] intValue ]: [midiData[1] intValue ]: [midiData[2] intValue]];
    
}

-(void)sendMidiMessageToDevice:(NSNotification*)notification {
    
     NSLog(@"Got notified: %@", notification);
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSArray *midiData = [userInfo objectForKey:@"data"];
    NSArray *device = [userInfo objectForKey:@"device"];

    NSLog(@"Status: %@", midiData);
    
    MIDIPacketList *packetList = [self getMidiPacket: [midiData[0] integerValue]: [midiData[1] integerValue] : [midiData[2] integerValue]];
   
    MIDIObjectRef endPoint;
    
    MIDIObjectType foundObj;
    
    MIDIObjectFindByUniqueID([device[1] intValue], &endPoint, &foundObj);
    
    MIDIEndpointRef endPointRef = (MIDIEndpointRef)endPoint;

    MIDIPortRef outPort;

    CFStringRef outPortName = (__bridge CFStringRef)[device[0] stringByAppendingFormat:@"%@", device[0]];

    MIDIOutputPortCreate([self newClient:outPortName], outPortName, &outPort);
    
    OSStatus result;
    
    result = MIDISend(outPort, endPointRef, packetList);

    if(result != noErr) {
        NSLog(@"Error sending midi: %s - %s",
              GetMacOSStatusErrorString(result),
              GetMacOSStatusCommentString(result));
        return;
    }
}

-(void)sendMidiMessage: (int)v1 :(int)v2 :(int)v3 {
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

-(void)updateMidiDestinations {
    
    ItemCount destCount = MIDIGetNumberOfDestinations();
    
    NSLog(@"Destinationcount: %i", (int)destCount);
    
//    MIDIEndpointRef endPointRefs[destCount];
//    MIDIPortRef portRefs[destCount];/
    
    NSMutableDictionary *devices = [NSMutableDictionary new];
    
    int deviceCount = 0;
    
    for (ItemCount i = 0 ; i < destCount ; i++) {
        
        // Grab a reference to a destination endpoint
        
        MIDIEndpointRef endPointRef = MIDIGetDestination(i);
        
        if (endPointRef) {
            
            NSNumber *deviceID = [NSNumber numberWithInt: [self getDeviceID: endPointRef]];
            
            NSString *deviceName = [self getDeviceName: endPointRef];
            
//            MIDIPortRef outPort;
//            
//            CFStringRef outPortName = (__bridge CFStringRef)[deviceName stringByAppendingFormat:@"%@", deviceName];
//        
//            MIDIOutputPortCreate([self newClient:outPortName], outPortName, &outPort);
            
            NSArray *device = @[deviceName, [NSNumber numberWithInteger: i]];
            
            [devices setObject: deviceName forKey: deviceID];
            
            deviceCount++;
        }

    }
    
    [[global sharedGlobalData] setMidiDestinations: devices];
    [[global sharedGlobalData] setMidiDestinationCount: deviceCount];
    
}

-(NSString*)getDeviceName:(MIDIObjectRef)object{
    // Returns the display name of a given MIDIObjectRef as an NSString
    CFStringRef name = nil;
    if (noErr != MIDIObjectGetStringProperty(object, kMIDIPropertyDisplayName, &name)) {
        NSLog(@"Problem");
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
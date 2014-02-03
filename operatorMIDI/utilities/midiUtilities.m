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
        if (dest != NULL) {
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

@end
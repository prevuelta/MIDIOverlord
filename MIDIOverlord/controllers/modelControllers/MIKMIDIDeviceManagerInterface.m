//
//  DeviceManagerInterface.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 24/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "MIKMIDIDeviceManagerInterface.h"

@implementation MIKMIDIDeviceManagerInterface

- (NSArray *)allSources {
    NSLog(@"SOURCES: %@", [self virtualSources]);
    return [self virtualSources];
}

@end

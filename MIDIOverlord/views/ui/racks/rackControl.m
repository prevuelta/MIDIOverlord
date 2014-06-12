//
//  rackControl.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 29/05/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "rackControl.h"

@implementation rackControl

@synthesize midiOutput = _midiOutput;
@synthesize midiInput = _midiInput;

-(void)addRackTitle {

    _midiInput = [[deviceList alloc] initWithFrame: @"MIDI IN"];
    [_midiInput setOrigin: NSMakePoint(0, 36)];
    
    [self addSubview: _midiInput];
    
    _midiOutput = [[deviceList alloc] initWithFrame: @"MIDI OUT"];
    [_midiOutput setOrigin: NSMakePoint(0, 48)];
    
    [self bind:@"deviceOut" toObject:_midiOutput withKeyPath:@"selectedValue" options:nil];
    
    [self addSubview: _midiOutput];
    
    // Add ui
    // Add Slider
    uiButton *addPad = [[uiButton alloc] initWithFrame: 15];
    [addPad setOrigin: NSMakePoint(20, self.headerHeight - 15)];
    [addPad setEvent: @"addModule" withData: @{@"type" : @1, @"rackID" : self.rackID }];
    
    uiButton *addSlider = [[uiButton alloc] initWithFrame: 15];
    [addSlider setOrigin: NSMakePoint(0, self.headerHeight - 15)];
    [addSlider setEvent: @"addModule" withData: @{@"type" : @2, @"rackID" : self.rackID }];
    
    [self addSubview: addPad];
    [self addSubview: addSlider];
    
    
}

-(void)createMidiDestinationsDeviceList:(NSNotification*)notification {
//    NSLog(@"Devices: %@", notification);
//    NSLog(@"%@", notification.userInfo);
    //    NSDictionary data = @{notification.object[0]}
    NSMutableArray *keyValues = [NSMutableArray new];
    for(NSString* key in notification.userInfo) {
        [keyValues addObject: [notification.userInfo objectForKey: key][0]];
        [keyValues addObject: key];
    }
//    NSLog(@"New device array %@", keyValues);
    
    [_midiOutput addOptions: keyValues];
}

@end

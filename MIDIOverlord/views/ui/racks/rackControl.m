//
//  rackControl.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 29/05/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "rackControl.h"

@implementation rackControl

-(void)addRackTitle {

     NSLog(@"Destinations: %@", [global sharedGlobalData].midiDestinations);
    
    uiTextField *label = [[uiTextField alloc] initWithString: @"Midi Out"];
    
    [label setDrawBg:NO];
    [label setOrigin:NSMakePoint(4, 24)];
    
    [self addSubview: label];
    
    self.midiDestSelect = [[controlList alloc] initWithOptions: [global sharedGlobalData].midiDestinations andOptionCount: [global sharedGlobalData].midiDestinationCount];
    
    [self.midiDestSelect setOrigin: NSMakePoint(label.frameWidth + 12, 24)];
    
    if([self.data[@"midiDest"] count] > 0) {
        [self.midiDestSelect setSelectedOption: self.data[@"midiDest"]];
    }
        
    [self.data bind:@"midiDest" toObject: self.midiDestSelect withKeyPath:@"selectedOption" options:nil];
    
    [self addSubview: self.midiDestSelect];
    
    
    
//    _midiOutput = [[deviceList alloc] initWithFrame: @"MIDI OUT"];
//    [_midiOutput setOrigin: NSMakePoint(4, 40)];
    
//    [self bind:@"deviceOut" toObject:_midiOutput withKeyPath:@"selectedValue" options:nil];
    
//    [self addSubview: _midiOutput];
    
    // Add ui
    // Add Slider
    uiButton *addPad = [[uiButton alloc] initWithSize: 20];
    [addPad setOrigin: NSMakePoint(28, self.headerHeight - 24)];
    [addPad setEvent: @"addModule" withData: @{@"type" : @1, @"rackID" : self.rackID }];
    
    uiButton *addSlider = [[uiButton alloc] initWithSize: 20];
    [addSlider setOrigin: NSMakePoint(4, self.headerHeight - 24)];
    [addSlider setEvent: @"addModule" withData: @{@"type" : @2, @"rackID" : self.rackID }];
    
    [self addSubview: addPad];
    [self addSubview: addSlider];
    
    // Observers
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createMidiDestinationsDeviceList:) name:@"updateMidiDestinations" object:nil];
    
}

//-(void)createMidiDestinationsDeviceList:(NSNotification*)notification {
//    NSMutableArray *keyValues = [NSMutableArray new];
//    NSLog(@"keyValues: %@", keyValues);
//    for(NSString* key in notification.userInfo) {
//        [keyValues addObject: [notification.userInfo objectForKey: key][0]];
//        [keyValues addObject: key];
//    }
//    [_midiOutput addOptions: keyValues];
//}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

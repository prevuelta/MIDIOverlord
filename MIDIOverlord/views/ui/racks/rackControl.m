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
    
    uiTextField *label = [[uiTextField alloc] initWithString: @"Send to:"];
    
    [label setDrawBg:NO];
    [label setOrigin:NSMakePoint(4, 24)];
    
    [self addSubview: label];
    
    [self updateMidiDestinations: nil];
    
    self.midiDeviceController = [[NSArrayController alloc] initWithContent: _deviceArray];
    
    [self.midiDeviceController addObserver:self forKeyPath:@"deviceArray" options: 0 context: NULL];
    
    [self.midiDeviceController bind:@"content" toObject:self withKeyPath: @"deviceArray" options: nil];
    
    [self.midiDeviceController setAvoidsEmptySelection: NO];

    
    self.midiDestSelect = [[controlList alloc] initWithContent: _deviceArray];

    [self.midiDestSelect bind:@"content" toObject:self.midiDeviceController withKeyPath: @"arrangedObjects" options:nil];
    
//    [self.midiDestSelect bind:@"selectedIndex" toObject: self.midiDeviceController withKeyPath: @"selectionIndex" options:nil];
    
    [self.midiDestSelect setOrigin: NSMakePoint(label.frameWidth + 12, 24)];
    
    [self addSubview: self.midiDestSelect];
    
    
    self.midiChannelControl = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"channel"]];
    
    [self.midiChannelControl setOriginWithX: self.label.frameWidth + 4 andY: 4];
    
    [self.midiChannelControl setMax: 16];
    [self.midiChannelControl setMin: 1];
    
    [self.data bind:@"channel" toObject: self.midiChannelControl withKeyPath:@"value" options:nil];
    
    [self addSubview: self.midiChannelControl ];
    
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMidiDestinations:) name:@"MIKMIDIDeviceWasAddedNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMidiDestinations:) name:@"MIKMIDIVirtualEndpointWasAddedNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMidiDestinations:) name:@"MIKMIDIVirtualEndpointWasRemovedNotification" object:nil];
    
}

-(void)updateMidiDestinations:(NSNotification*)notification {
    NSMutableArray *allDestinations = [[[MIKMIDIDeviceManagerInterface sharedDeviceManager] virtualDestinations] mutableCopy];
//    [allDestinations addObjectsFromArray: [[MIKMIDIDeviceManagerInterface sharedDeviceManager] availableDevices]];
//    [allDestinations addObject: @{@"name": @"None", @"value" : @0}];
    [self setDeviceArray: allDestinations];
    NSLog(@"updated destinations");
}
    
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

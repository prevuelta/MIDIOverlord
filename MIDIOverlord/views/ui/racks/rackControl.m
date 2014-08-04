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
    
    uiTextField *sendLabel = [[uiTextField alloc] initWithString: @"Send to:"];
    uiTextField *listenLabel = [[uiTextField alloc] initWithString: @"Listen to:"];
    
    [sendLabel setDrawBg:NO];
    [listenLabel setDrawBg:NO];
    
    [sendLabel setOrigin:NSMakePoint(4, 44)];
    [listenLabel setOrigin:NSMakePoint(4, 24)];
    
    [self addSubview: sendLabel];
    [self addSubview: listenLabel];
    
    [self updateMidiDestinations: nil];
    
    self.midiSend = [[controlList alloc] initWithContent: _deviceArray];
    self.midiListen = [[controlList alloc] initWithContent: _deviceArray];
    
    [self.midiSend setOrigin: NSMakePoint(RACK_WIDTH - self.midiSend.frameWidth - 4, 44)];
    [self.midiListen setOrigin: NSMakePoint(RACK_WIDTH - self.midiSend.frameWidth - 4, 24)];
    
    [self addSubview: self.midiSend];
    [self addSubview: self.midiListen];
    
//    self.midiDeviceController = [[NSArrayController alloc] initWithContent: _deviceArray];
//    
//    [self.midiDeviceController addObserver:self forKeyPath:@"deviceArray" options: 0 context: NULL];
//
    [self.midiSend bind:@"content" toObject: self withKeyPath:@"deviceArray" options: nil];
    
//    [self.midiSend bind:@"content" toObject:self withKeyPath: @"deviceArray" options: nil];
//
//    [self.midiDeviceController setAvoidsEmptySelection: NO];
//    
//    self.midiDestSelect = [[controlList alloc] initWithContent: _deviceArray];
//
//    [self.midiDestSelect bind:@"content" toObject:self.midiDeviceController withKeyPath: @"arrangedObjects" options:nil];
//    
////    [self.midiDestSelect bind:@"selectedIndex" toObject: self.midiDeviceController withKeyPath: @"selectionIndex" options:nil];
//    
//    [self.midiDestSelect setOrigin: NSMakePoint(label.frameWidth + 12, 24)];
//    
//    [self addSubview: self.midiDestSelect];
    
    
    self.midiChannelControl = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"channel"]];
    
    [self.midiChannelControl setOriginWithX: self.label.frameWidth + 8 andY: 4];
    
    [self.midiChannelControl setMax: 16];
    [self.midiChannelControl setMin: 1];
    
    [self.data bind:@"channel" toObject: self.midiChannelControl withKeyPath:@"value" options:nil];
    
    [self addSubview: self.midiChannelControl ];
    
    
    // Add ui
    // Add Slider
    uiButton *addPad = [[uiButton alloc] initWithSize: 20 andEvent: @"addPads"];
    [addPad setOrigin: NSMakePoint(28, self.headerHeight - 24)];
    [addPad setEventData: @{@"type" : @1, @"rackID" : self.rackID }];
    
    uiButton *addSlider = [[uiButton alloc] initWithSize: 20 andEvent:@"addSlider"];
    [addSlider setOrigin: NSMakePoint(4, self.headerHeight - 24)];
    [addSlider setEventData: @{@"type" : @2, @"rackID" : self.rackID }];
    
    [self addSubview: addPad];
    [self addSubview: addSlider];
    
    // Observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMidiDestinations:) name:@"MIKMIDIDeviceWasAddedNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMidiDestinations:) name:@"MIKMIDIVirtualEndpointWasAddedNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMidiDestinations:) name:@"MIKMIDIVirtualEndpointWasRemovedNotification" object:nil];
    
}

-(void)updateMidiDestinations:(NSNotification*)notification {
    _deviceArray = [[MIKMIDIDeviceManagerInterface sharedDeviceManager] virtualDestinations];
//    [allDestinations addObjectsFromArray: [[MIKMIDIDeviceManagerInterface sharedDeviceManager] availableDevices]];
//    [allDestinations addObject: @{@"name": @"None", @"value" : @0}];
//    [self setDeviceArray: allDestinations];
//    NSLog(@"updated destinations");
}
    
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(moduleBase*)getModuleWithData:(NSMutableDictionary*)moduleData{
    
    moduleBase *module;
    
    switch([moduleData[@"type"] intValue]) {
        case 1: {
            module = [[modulePad alloc] initWithData: moduleData];
            //            NSLog(@"added pad");
        } break;
        case 2: {
            module = [[moduleSlider alloc] initWithData: moduleData];
            //            NSLog(@"added slider");
        } break;
    }
    
    return module;
    
}


@end

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
    
    /* Midi connections */
    
    uiTextField *listenLabel = [[uiTextField alloc] initWithString: @"Listen to:"];
    uiTextField *sendLabel = [[uiTextField alloc] initWithString: @"Speak to:"];
    
    [sendLabel setDrawBg:NO];
    [listenLabel setDrawBg:NO];
    
    [sendLabel setOrigin:NSMakePoint(4, 44)];
    [listenLabel setOrigin:NSMakePoint(4, 24)];
    
    [self addSubview: sendLabel];
    [self addSubview: listenLabel];
   

    self.midiListen = [[controlList alloc] initWithContent: [[MIKMIDIDeviceManager sharedDeviceManager] virtualSources]];
    self.midiSend = [[controlList alloc] initWithContent: [[MIKMIDIDeviceManager sharedDeviceManager] virtualDestinations]];
    
    [self.midiListen bind: @"content" toObject: [MIKMIDIDeviceManager sharedDeviceManager] withKeyPath:@"virtualSources" options:nil];
    [self.midiSend bind: @"content" toObject: [MIKMIDIDeviceManager sharedDeviceManager] withKeyPath:@"virtualDestinations" options:nil];
    
    [self.midiListen setOrigin: NSMakePoint(RACK_WIDTH - self.midiSend.frameWidth - 4, 24)];
    [self.midiSend setOrigin: NSMakePoint(RACK_WIDTH - self.midiSend.frameWidth - 4, 44)];
    
    [self addSubview: self.midiListen];
    [self addSubview: self.midiSend];
 
    /* Channel control */
    
    self.midiChannelControl = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"channel"]];
    
    [self.midiChannelControl setOriginWithX: self.label.frameWidth + 8 andY: 4];
    
    [self.midiChannelControl setMax: 16];
    [self.midiChannelControl setMin: 1];
    
    [self.data bind:@"channel" toObject: self.midiChannelControl withKeyPath:@"value" options:nil];
    
    [self addSubview: self.midiChannelControl ];
    
    
    /* UI buttons */
    
    uiButton *addPad = [[uiButton alloc] initWithSize: 20 andEvent: @"addPads"];
    [addPad setOrigin: NSMakePoint(28, self.headerHeight - 24)];
    [addPad setEventData: @{@"type" : @1, @"rackID" : self.rackID }];
    
    uiButton *addSlider = [[uiButton alloc] initWithSize: 20 andEvent:@"addSlider"];
    [addSlider setOrigin: NSMakePoint(4, self.headerHeight - 24)];
    [addSlider setEventData: @{@"type" : @2, @"rackID" : self.rackID }];
    
    uiButton *addMap = [[uiButton alloc] initWithSize: 20 andEvent:@"addMap"];
    [addMap setOrigin: NSMakePoint(52, self.headerHeight - 24)];
    [addMap setEventData: @{@"type" : @3, @"rackID" : self.rackID }];
    
    [self addSubview: addPad];
    [self addSubview: addSlider];
    [self addSubview: addMap];
    
    /* Observers */

    
}

    
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(moduleBase*)getModuleWithData:(NSMutableDictionary*)moduleData{
    
    moduleBase *module;
    
    switch([moduleData[@"type"] intValue]) {
        case 1: {
            module = [[modulePads alloc] initWithData: moduleData];
        } break;
        case 2: {
            module = [[moduleSlider alloc] initWithData: moduleData];
        } break;
        case 3: {
            module = [[moduleMap alloc] initWithData: moduleData];
        } break;
    }
    
    return module;
    
}


@end

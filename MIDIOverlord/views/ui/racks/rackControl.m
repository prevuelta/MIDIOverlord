//
//  rackControl.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 29/05/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "rackControl.h"

@implementation rackControl

@synthesize receiveDevice = _receiveDevice;

-(void)addRackTitle {
    
    /* Midi connections */
    
    uiTextField *receiveLabel = [[uiTextField alloc] initWithString: @"Receive From:"];
    uiTextField *sendLabel = [[uiTextField alloc] initWithString: @"Send to:"];
    
    [sendLabel setDrawBg:NO];
    [receiveLabel setDrawBg:NO];
    
    [sendLabel setOrigin:NSMakePoint(4, 44)];
    [receiveLabel setOrigin:NSMakePoint(4, 24)];
    
    [self addSubview: sendLabel];
    [self addSubview: receiveLabel];
   

    self.midireceive = [[controlList alloc] initWithContent: [[MIKMIDIDeviceManager sharedDeviceManager] virtualSources]];
    self.midiSend = [[controlList alloc] initWithContent: [[MIKMIDIDeviceManager sharedDeviceManager] virtualDestinations]];
    
    [self.midireceive bind: @"content" toObject: [MIKMIDIDeviceManager sharedDeviceManager] withKeyPath:@"virtualSources" options:nil];
    [self.midiSend bind: @"content" toObject: [MIKMIDIDeviceManager sharedDeviceManager] withKeyPath:@"virtualDestinations" options:nil];
    
    [self bind:@"receiveDevice" toObject: self.midireceive withKeyPath: @"selectedObject" options: nil];
    
    [self.midireceive setOrigin: NSMakePoint(RACK_WIDTH - self.midiSend.frameWidth - 4, 24)];
    [self.midiSend setOrigin: NSMakePoint(RACK_WIDTH - self.midiSend.frameWidth - 4, 44)];
    
    [self addSubview: self.midireceive];
    [self addSubview: self.midiSend];
 
    /* Channel control */
    
    self.midiChannelControl = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"channel"]];
    
    [self.midiChannelControl setOriginWithX: self.label.frameWidth + 8 andY: 4];
    
    [self.midiChannelControl setMax: 16];
    [self.midiChannelControl setMin: 1];
    
    [self.data bind:@"channel" toObject: self.midiChannelControl withKeyPath:@"value" options:nil];
    
    [self addSubview: self.midiChannelControl ];
    
    
    /* UI buttons */
    
    uiButton *addSlider = [[uiButton alloc] initWithSize: 20 andEvent:@"addPads"];
    [addSlider setOrigin: NSMakePoint(4, self.headerHeight - 24)];
    [addSlider setEventData: @{@"type" : @1, @"rackID" : self.rackID }];
    
    uiButton *addPad = [[uiButton alloc] initWithSize: 20 andEvent: @"addSlider"];
    [addPad setOrigin: NSMakePoint(28, self.headerHeight - 24)];
    [addPad setEventData: @{@"type" : @2, @"rackID" : self.rackID }];
    
    uiButton *addMap = [[uiButton alloc] initWithSize: 20 andEvent:@"addMap"];
    [addMap setOrigin: NSMakePoint(52, self.headerHeight - 24)];
    [addMap setEventData: @{@"type" : @3, @"rackID" : self.rackID }];
    
    [self addSubview: addPad];
    [self addSubview: addSlider];
    [self addSubview: addMap];
    
    /* Observers */


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
            NSLog(@"Map module");
            module = [[moduleMap alloc] initWithData: moduleData];
        } break;
    }
    
    return module;
    
}

-(void)midireceiveHandler:(NSNotification*)notification {
    
    /* Setup mapping receiveer */
    
    NSError *mappingError;
    
    if(self.midireceive.selectedObject) {
        
        MIKMIDIMappingGenerator *inputMapper = [[MIKMIDIMappingGenerator alloc] initWithDevice: self.midireceive.selectedObject error: &mappingError];
        
    }
}

-(void)setreceiveDevice:(MIKMIDIEndpoint*)receiveDevice {
    NSLog(@"Set receiveing device:%@", receiveDevice);
    _receiveDevice = receiveDevice;
}

-(MIKMIDIEndpoint*)receiveDevice {
    return _receiveDevice;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

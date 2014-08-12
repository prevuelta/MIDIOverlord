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

    uiTextField *receiveLabel = [[uiTextField alloc] initWithString: @"Rec:"];
    uiTextField *sendLabel = [[uiTextField alloc] initWithString: @"Send:"];

    [sendLabel setDrawBg:NO];
    [receiveLabel setDrawBg:NO];

    [sendLabel setOrigin:NSMakePoint(4, 45)];
    [receiveLabel setOrigin:NSMakePoint(4, 25)];

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

    /* Channel controls */

    self.receiveChannel = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"receiveChannel"] andNullString: @"All"];
    self.sendChannel = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"sendChannel"] andNullString: @"All"];

    [self.receiveChannel setOriginWithX: 52 andY: 25];
    [self.sendChannel setOriginWithX: 52 andY: 45];

    
    [self.receiveChannel setMax: 16];
    [self.receiveChannel setMin: 1];

    [self.sendChannel setMax: 16];
    [self.sendChannel setMin: 1];

    [self.data bind:@"receiveChannel" toObject: self.receiveChannel withKeyPath:@"value" options:nil];
    [self.data bind:@"sendChannel" toObject: self.sendChannel withKeyPath:@"value" options:nil];

    [self addSubview: self.receiveChannel ];
    [self addSubview: self.sendChannel ];


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

-(void)receiveHandler:(NSNotification*)notification {

    /* Setup mapping receiveer */

    MIKMIDIDeviceManager *manager = [MIKMIDIDeviceManager sharedDeviceManager];

    NSError *error;

    BOOL success = [manager connectInput: self.receiveDevice  error: &error eventHandler:^(MIKMIDISourceEndpoint *source, NSArray *commands) {

               for (MIKMIDICommand *command in commands) {
                    NSLog(@"Incoming MIDI: %@", command);
//                   [[NSNotificationCenter defaultCenter] postNotificationName:@"midiCommand" object:self userInfo: @{@"command" : command}];
                  id<MIKMIDIResponder> responder = [NSApp MIDIResponderWithIdentifier: @"What"];
                   if ([responder respondsToMIDICommand:command]) {
//                        [responder handleMIDICommand:command];
                   }
                   // [self routeIncomingMIDICommand:command];
               }
               
           }];

//    if (success) self.device = device;
}



 //       - (void)routeIncomingMIDICommand:
 // *      {
 // *          MIKMIDIDevice *controller = self.device; // The connected MIKMIDIDevice instance
 // *          MIKMIDIMapping *mapping = [[[MIKMIDIMappingManager sharedManager] mappingsForControllerName:controller.name] anyObject];
 // *          MIKMIDIMappingItem *mappingItem = [[self.MIDIMapping mappingItemsForMIDICommand:command] anyObject];
 // *          if (!mappingItem) return;
 // *
 // *          id<MIKMIDIResponder> responder = [NSApp MIDIResponderWithIdentifier:mappingItem.MIDIResponderIdentifier];
 // *          if ([responder respondsToMIDICommand:command]) {
 // *              [responder handleMIDICommand:command];
 // *          }
 // *      }

    // NSError *mappingError;

    // if(self.midireceive.selectedObject) {

    //     MIKMIDIMappingGenerator *inputMapper = [[MIKMIDIMappingGenerator alloc] initWithDevice: self.midireceive.selectedObject error: &mappingError];

-(void)setReceiveDevice:(MIKMIDISourceEndpoint*)receiveDevice {
    NSLog(@"Set receiveing device:%@", receiveDevice);
    _receiveDevice = receiveDevice;
    [self receiveHandler: nil];
}

-(MIKMIDISourceEndpoint*)receiveDevice {
    return _receiveDevice;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

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
    [receiveLabel setIsInverted: YES];
    
    uiTextField *sendLabel = [[uiTextField alloc] initWithString: @"Send:"];
    [sendLabel setIsInverted: YES];

    [sendLabel setDrawBg:NO];
    [receiveLabel setDrawBg:NO];

    [receiveLabel setOrigin:NSMakePoint(4, 24)];
    [sendLabel setOrigin:NSMakePoint(4, 44)];
    

    [self addSubview: sendLabel];
    [self addSubview: receiveLabel];

    self.midiReceive = [[controlList alloc] initWithContent: [[MIKMIDIDeviceManager sharedDeviceManager] virtualSources]];
    self.midiSend = [[controlList alloc] initWithContent: [[MIKMIDIDeviceManager sharedDeviceManager] virtualDestinations]];

    [self.midiReceive bind: @"content" toObject: [MIKMIDIDeviceManager sharedDeviceManager] withKeyPath:@"virtualSources" options:nil];
    [self.midiSend bind: @"content" toObject: [MIKMIDIDeviceManager sharedDeviceManager] withKeyPath:@"virtualDestinations" options:nil];

    [self bind:@"receiveDevice" toObject: self.midiReceive withKeyPath: @"selectedObject" options: nil];

    [self.midiReceive setOrigin: NSMakePoint(100, 24)];
    [self.midiSend setOrigin: NSMakePoint(100, 44)];

    [self addSubview: self.midiReceive];
    [self addSubview: self.midiSend];

    /* Channel controls */

    self.receiveChannel = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"receiveChannel"] andNullString: @"All"];
    
    self.sendChannel = [[controlText alloc] initWithLabel: @"CH" andValue: self.data[@"sendChannel"] andNullString: @"All"];
    
    [self.receiveChannel setOriginWithX: 50 andY: 24];
    [self.sendChannel setOriginWithX: 50 andY: 44];
    
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
            module = [[modulePad alloc] initWithData: moduleData];
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

-(void)startListening {

    /* Setup mapping receiveer */

    MIKMIDIDeviceManager *manager = [MIKMIDIDeviceManager sharedDeviceManager];

    NSError *error;

    NSLog(@"Start listing");
    
    BOOL success = [manager connectInput: self.receiveDevice  error: &error eventHandler:^(MIKMIDISourceEndpoint *source, NSArray *commands) {

       for (MIKMIDICommand *command in commands) {
           
           // Check type of command ** THIS HANDLING IS POO
           [self.midiIndicator ping];
           
           MIKMIDIChannelVoiceCommand *channelCommand = (MIKMIDIChannelVoiceCommand*)command;
           
           int receiveChannel = [self.data[@"receiveChannel"] intValue];
           
//           NSLog(@"%i", receiveChannel);
           
           if(receiveChannel < 0 | channelCommand.channel == (receiveChannel-1)) {
//
               NSLog(@"Sending command");
//
              [[NSNotificationCenter defaultCenter] postNotificationName:NSStringFromClass([command class])  object:self userInfo: @{@"command":command}];
//
           }
        
           
           // Check channel
           
//           if() {
           
//           }
           
//
           
           /* Add mapping item */
//           
//           if(self.isRecording) {

//               NSLog(@"Setting mapping %i", self.isRecording);
//               [self setIsRecording: NO];
           
//               [global deselectNotify];
           
//               [self.mappings addObject: @{command : @[self.currentMIDIIdentifier]}];
               
//               MIKMIDIMappingItem *mappingItem = [[self.MIDIMapping mappingItemsForMIDICommand:command] anyObject];
               
//               MIKMIDIMappingItem *newMapping = [[MIKMIDIMappingItem alloc] initWithMIDIResponderIdentifier: self.currentMIDIIdentifier andCommandIdentifier: @"1-0"];
//               
//               [self.mappings addMappingItemsObject: newMapping ];
//               
//               [global stopRecordingNotify];
//           }
           
           // Check commands array
           
//           MIKMIDIMappingItem *mappingItem = [[self.MIDIMapping mappingItemsForMIDICommand:command] anyObject];
           
//           NSLog(@"Mappings: %@", self.mappings);
           
           // Check status mapping
           // If command is mapped
            // Get module/s that are mapped
           // Send command to modules
           
//            NSLog(@"Incoming MIDI: %@", command.commandType);

//        [global stopRecordingNotify];
           
//           
//          id<MIKMIDIResponder> responder = [NSApp MIDIResponderWithIdentifier: @"1-0"];
//           NSLog(@"Responder: %@", responder);
//           if ([responder respondsToMIDICommand:command]) {
//                [responder handleMIDICommand:command];
//           }
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

-(void)stopListening {
    
    MIKMIDIDeviceManager *manager = [MIKMIDIDeviceManager sharedDeviceManager];
   
    NSError *error;
    
    [manager disconnectInput:self.receiveDevice forConnectionToken: error];
    
}

-(void)setReceiveDevice:(MIKMIDISourceEndpoint*)receiveDevice {
    NSLog(@"Set receiving device:%@", receiveDevice);
    
    if(!receiveDevice) {
        [self stopListening];
         _receiveDevice = nil;
    } else {
         _receiveDevice = receiveDevice;
        [self startListening];
    }
   
}

-(MIKMIDISourceEndpoint*)receiveDevice {
    return _receiveDevice;
}

-(void)startMap:(NSDictionary*)mID{
//    self.currentMIDIIdentifier = MIDIIdentifier;'
    NSLog(@"Received event %@", mID);
    
    [self.modulesInputMap addEntriesFromDictionary: mID];
    
//    NSLog(@"%@", self.modulesInputRecord);
    
//    [self setIsRecording: YES];
   
//    NSLog(@"Delegate received: %@ Isrecording: %i", MIDIIdentifier, self.isRecording);
}



@end

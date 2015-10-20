//
//  moduleSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleSlider.h"

@implementation moduleSlider

@synthesize ccValue = _ccValue;
@synthesize data = _data;

-(id)initWithData:(NSMutableDictionary*)data {
    
    self = [super initWithUnitWidth: data[@"unitWidth"] andUnitHeight: data[@"unitHeight"]];
    
    if(!self) return nil;
    
    _ccValue = 0;
    
    self.flipped = YES;
    
    _data = data;
    
    self.MIDIIdentifier = data[@"moduleID"];
    
    /* Receive CC */
    
    self.receiveMap = [[uiButton alloc] initWithSize: 16 andEvent: @"receiveRecord"];
    
    [self.receiveMap setOriginWithY: 16];
    [self.receiveMap setSendsEvent: NO];
    [self.receiveMap setIsToggle: YES];
    
    [self bind:@"isMapping" toObject:self.receiveMap withKeyPath:@"toggled" options:nil];
    [self.receiveMap bind:@"toggled" toObject:self withKeyPath:@"isMapping" options:nil];
    
    [self addSubview: self.receiveMap];
    
    controlText *receiveCC = [[controlText alloc] initWithLabel: @"" andValue: data[@"receiveCC"]];
    [receiveCC setOrigin:NSMakePoint(16, 16)];
    [_data bind:@"receiveCC" toObject: receiveCC withKeyPath:@"value" options:nil];
    
    [self addSubview: receiveCC ];
    
    // _receiveValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"receiveNoteValue"]];
    
    /* Add dial */
    
    _dial = [[controlDial alloc] initWithSize: 48 andValue: data[@"ccValue"] ];
    [_dial setOriginWithX: 48 andY: 16];
    [self addSubview: _dial];
    
    [self bind:@"ccValue" toObject:_dial withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_dial withKeyPath:@"value" options:nil];
//    [_dial bind:@"value" toObject: self withKeyPath: @"ccValue" options:nil];
    
    int controlY = 0;
    
    /* Add Label */
    
    self.label = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 10];
    [self.label setOrigin:NSMakePoint(0, 0)];
    
    [_data bind:@"label" toObject: self.label withKeyPath:@"savedString" options:nil];
    
    [self addSubview: self.label];
    
    controlY += self.label.frameWidth + 2;
   
    
    /* Setup output */
    
    controlText *sendCC = [[controlText alloc] initWithLabel: @"" andValue: data[@"sendCC"]];
    [sendCC setOrigin:NSMakePoint(16, 32)];
    [_data bind:@"sendCC" toObject: sendCC withKeyPath:@"value" options:nil];

    [self addSubview: sendCC ];
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 16 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(self.width - 16, 0)];

    [self addSubview: removeBtn];
    
//    uiToggle *toggleRelative = [[uiToggle alloc]];
    
    /* CC Value */
    
    _valueField = [[uiTextField alloc] initWithString: [_data[@"ccValue"] stringValue] andMaxLength:3];
    [_valueField setOriginWithX: 16 andY: 48];
    
    [self addSubview: _valueField];
    
    /* Add observers */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMIDIControlChangeCommand:) name:@"MIKMIDIControlChangeCommand" object:nil];
    
    
    return self;
}

-(NSNumber*)ccValue {
    return _ccValue;
}

-(void)setCcValue:(NSNumber*)ccValue {
    _ccValue = ccValue;
    [_valueField setStringValue: [self.ccValue stringValue]];
    if(![self.data[@"sendCC"] isEqualToNumber:@-1]) {
        [self.delegate midiCommand: @[self.data[@"ccStatus"], self.data[@"sendCC"], self.data[@"ccValue"]]];
    }
}

-(void)handleMIDIControlChangeCommand:(NSNotification*)notification {
    
    MIKMIDIControlChangeCommand *command = notification.userInfo[@"command"];
    
//    NSLog(@"Command received %@", command);
    
    // Set note mapping if recording
    if(self.isMapping) {

        // Handle mapping

        [self setIsMapping: NO];
        
    } else if([command controllerNumber] == [_data[@"receiveCC"] integerValue]) {

        [_dial setValue: [NSNumber numberWithInteger: [command controllerValue]]];
        [_valueField setStringValue:[NSString stringWithFormat:@"%d", [command controllerValue]]];
        
        // Show/set velocity
//        [self.velocitySlider setValue: [NSNumber numberWithInteger: [command velocity]]];
//        [self setActive: YES];

    }
    
   
}



-(void)mouseDown:(NSEvent *)theEvent {
    
}


@end

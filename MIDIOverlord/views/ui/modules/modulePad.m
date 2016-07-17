//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

@synthesize active = _active;

-(id)initWithData: (NSMutableDictionary*)data{
    
    self = [super initWithUnitWidth: data[@"unitWidth"] andUnitHeight: data[@"unitHeight"]];
    
    if(!self) return nil;
    
    [self setFlipped: YES];
    
    self.data = data;
    
    _min = 0;
    _max = 127;
    _range = _max;
    
    
    /* UI */
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 16 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint([self getWidth] - 16, 0)];
    [removeBtn setInEditView:YES];
    
    [self addSubview: removeBtn];
    
    /* Add Label */
    
    self.label = [[uiEditableTextField alloc] initWithString: self.data[@"label"] andMaxLength: 10];
    [self.label setOrigin:NSMakePoint(0, 0)];
    
    [self.data bind:@"label" toObject: self.label withKeyPath:@"savedString" options:nil];
    
    [self addSubview: self.label];
    
    /* Input */
    
    /* Mapping button */
    
    self.receiveMap = [[uiButton alloc] initWithSize: 16 andEvent: @"receiveMap"];
    [self.receiveMap setOriginWithY: 16];
    [self.receiveMap setSendsEvent: NO];
    [self.receiveMap setIsToggle: YES];
    
    [self bind:@"isMapping" toObject:self.receiveMap withKeyPath:@"toggled" options:nil];
    
    [self addSubview: self.receiveMap];

    /* Receive value */
    
    self.receiveValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"receiveNoteValue"]];
    
    uiNoteField *receiveNote = [[uiNoteField alloc] initWithString: [utilities noteName: [data[@"receiveNoteValue"] intValue] ]];
    
    [self.data bind:@"receiveNoteValue" toObject: _receiveValue withKeyPath: @"value" options: nil];

    [receiveNote bind:@"noteValue" toObject: _receiveValue withKeyPath: @"value" options: nil];
    [receiveNote bind:@"hidden" toObject: _receiveValue.valueNumberField withKeyPath: @"isEditing" options: nil];

    [self.receiveValue setOriginWithX: 16 andY: 16];
    
    [receiveNote setOriginWithX: 16 andY: 16];

    [self addSubview: _receiveValue ];
    [self addSubview: receiveNote ];

    /* Output */
    
    uiButton *sendRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"sendMap"];
    [sendRecord setOrigin: NSMakePoint(0, 32)];
    [sendRecord setIsToggle: YES];
    
    [self addSubview: sendRecord];
    
//    controlText *noteValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"sendNoteValue"]];
//    uiNoteField *note = [[uiNoteField alloc] initWithString:  [utilities noteName: [data[@"sendNotevalue"] intValue] ]];
    
//    [data bind:@"sendNoteValue" toObject: noteValue withKeyPath: @"value" options: nil];
    //
//    [note bind:@"noteValue" toObject: noteValue withKeyPath: @"value" options: nil];
//    [note bind:@"hidden" toObject: noteValue.valueNumberField withKeyPath: @"isEditing" options: nil];

//    [self bind:@"sendNoteValue" toObject:receiveValue withKeyPath:@"value" options:nil];
    
//    [noteValue setOriginWithX: 16 andY: 32];
//    [note setOriginWithX: 16 andY: 32];
//    
//    [self addSubview: noteValue ];
//    [self addSubview: note ];
//    
    /* Velocity */
    
    _velocitySlider = [[controlSlider alloc] initWithSize:NSMakeSize(12, 48) andValue: data[@"velocity"] andMinValue: 0 andMaxValue: 127 andIsVertical: YES];
    
    [_velocitySlider setIsVertical: YES];
    [_velocitySlider setOriginWithX: 44 andY: 16];
    
    [self.data bind:@"velocity" toObject: _velocitySlider withKeyPath: @"value" options: nil];
    
    [self addSubview: _velocitySlider];
    
    
    /* Trigger */
    
    NSSize padSize = NSMakeSize(40, 40);
    
    _trigger = [[controlTrigger alloc] initWithSize: padSize andValue: data[@"velocity"]];
    
    [_trigger setOriginWithX: 56 andY: 16];
    
    [self bind:@"active" toObject: _trigger withKeyPath:@"active" options: nil];
    [_trigger bind:@"value" toObject: _velocitySlider withKeyPath:@"value" options: nil];
    
    [self addSubview: _trigger];

    
    /* Lock veolocity */
    
//    uiButton *lockVelocity = [[uiButton alloc] initWithSize: 12 andEvent: @"lockVelocity"];
//    
//    [lockVelocity setOrigin: NSMakePoint(2, self.frameHeight - 12 )];
    
//    [lockVelocity setIsToggle: YES];
    
    /* Observers */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMIDINoteOnCommand:) name:@"MIKMIDINoteOnCommand" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMIDINoteOffCommand:) name:@"MIKMIDINoteOffCommand" object:nil];
    
    return self;
}

-(void)handleMIDINoteOnCommand:(NSNotification*)notification {

    MIKMIDINoteOnCommand *command = notification.userInfo[@"command"];
    
    // Set note mapping if recording
    if(self.isMapping) {
        
        // Handle mapping
        [self.receiveValue setValue: [NSNumber numberWithInteger:[command note]]];
        [self.velocitySlider setValue: [NSNumber numberWithInteger: [command velocity]]];
        
        [self setIsMapping: NO];
        
    } else if([self.receiveValue.value integerValue] == [command note]) {
    
        // Show/set velocity
        [self.velocitySlider setValue: [NSNumber numberWithInteger: [command velocity]]];

        [self setActive: YES];
    
    }
    
}

-(void)handleMIDINoteOffCommand:(NSNotification*)notification {
    
    MIKMIDINoteOffCommand *command = notification.userInfo[@"command"];
    
    if([self.receiveValue.value integerValue] == [command note]) {
        NSLog(@"Setting active to false");
        [self setActive: NO];
    }
}

-(BOOL)active {
    return _active;
}


-(void)stopMapping:(NSNotification*)notification {
    NSLog(@"Stopping recording");
    [self.receiveMap setToggled: NO];
}

-(void)setActive:(BOOL)active {
    if(![self.data[@"sendNotevalue"] isEqualToNumber:@-1]) {
        if(active) {
            NSLog(@"Sending command");
            [self.delegate midiCommand: @[self.data[@"noteOnStatus"], self.data[@"sendNoteValue"], self.data[@"velocity"]]];
        } else {
            [self.delegate midiCommand: @[self.data[@"noteOffStatus"], self.data[@"sendNoteValue"], @0]];
        }
    }
    
    [_trigger setActive: active];
    _active = active;
}

@end

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
@synthesize isRecording = _isRecording;

-(id)initWithData: (NSMutableDictionary*)data{
    
    self = [super initWithSize: NSMakeSize( [global getUnitWidth:1], 42)];
    
    if(!self) return nil;
    
    [self setFlipped: YES];
    
//    data = data;
    
    _min = 0;
    _max = 127;
    _range = _max;
    
    self.unitSize = [data[@"unitSize"] intValue];
    
//    NSLog(@"Self data: %@", data[@"velocity"]);
    
    /* Input */
    
    self.receiveRecordBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"receiveRecord"];
    [self.receiveRecordBtn setOriginWithY: 0];
    [self.receiveRecordBtn setSendsEvent: NO];
    [self.receiveRecordBtn setIsToggle: YES];
    
    [self bind:@"isRecording" toObject:self.receiveRecordBtn withKeyPath:@"toggled" options:nil];
    [self.receiveRecordBtn bind:@"toggled" toObject:self withKeyPath:@"isRecording" options:nil];
    
    [self addSubview: self.receiveRecordBtn];
    
    _receiveValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"receiveNoteValue"]];
    uiNoteField *receiveNote = [[uiNoteField alloc] initWithString: [utilities noteName: [data[@"receiveNoteValue"] intValue] ]];
    
    [data bind:@"receiveNoteValue" toObject: _receiveValue withKeyPath: @"value" options: nil];

    [receiveNote bind:@"noteValue" toObject: _receiveValue withKeyPath: @"value" options: nil];
    [receiveNote bind:@"hidden" toObject: _receiveValue.valueNumberField withKeyPath: @"isEditing" options: nil];

//    [self bind:@"receiveNotevalue" toObject:receiveValue withKeyPath:@"value" options:nil];
    
    [_receiveValue setOriginWithX: 12 andY: 0];
    [receiveNote setOriginWithX: 12 andY: 0];
    
    [self addSubview: _receiveValue ];
    [self addSubview: receiveNote ];
    
    /* Output */
    
    uiButton *sendRecord = [[uiButton alloc] initWithSize: 12 andEvent: @"sendRecord"];
    [sendRecord setOrigin: NSMakePoint(0, 14)];
    [sendRecord setIsToggle: YES];
    
    [self addSubview: sendRecord];
    
    controlText *noteValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"sendNoteValue"]];
    uiNoteField *note = [[uiNoteField alloc] initWithString:  [utilities noteName: [data[@"sendNotevalue"] intValue] ]];
    
    [data bind:@"sendNoteValue" toObject: noteValue withKeyPath: @"value" options: nil];
    //
    [note bind:@"noteValue" toObject: noteValue withKeyPath: @"value" options: nil];
    [note bind:@"hidden" toObject: noteValue.valueNumberField withKeyPath: @"isEditing" options: nil];

//    [self bind:@"sendNoteValue" toObject:receiveValue withKeyPath:@"value" options:nil];
    
    [noteValue setOriginWithX: 12 andY: 14];
    [note setOriginWithX: 12 andY: 14];
    
    [self addSubview: noteValue ];
    [self addSubview: note ];
    
    /* Velocity */
    
    _velocitySlider = [[controlSlider alloc] initWithSize:NSMakeSize(12, 40) andValue: data[@"velocity"] andMinValue: 0 andMaxValue: 127 andIsVertical: YES];
    
//    [_velocitySlider setIsVertical: YES];
    [_velocitySlider setOriginWithX: 38 andY: 0];
    
    [data bind:@"velocity" toObject: _velocitySlider withKeyPath: @"value" options: nil];
    
    [self addSubview: _velocitySlider];
    
    /* Trigger */
    
    NSSize padSize = NSMakeSize(40, 40);
    
    controlTrigger *trigger = [[controlTrigger alloc] initWithSize: padSize andValue: data[@"velocity"]];
    
    [trigger setOriginWithX: 50 andY: 0];
    
    [self bind:@"active" toObject: trigger withKeyPath:@"active" options: nil];
    
    [trigger bind:@"value" toObject: _velocitySlider withKeyPath:@"value" options: nil];
    
    [self addSubview: trigger];
    
//     NSLog(@"Pad data: %@", data);

    
    /* Lock veolocity */
    
    uiButton *lockVelocity = [[uiButton alloc] initWithSize: 12 andEvent: @"lockVelocity"];
    
    [lockVelocity setOrigin: NSMakePoint(2, self.frameHeight - 12 )];
    
    [lockVelocity setIsToggle: YES];
    
    /* Observers */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMIDICommand:) name:@"MIKMIDINoteOnCommand" object:nil];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {

}

-(void)handleMIDICommand:(NSNotification*)notification {

    
    MIKMIDINoteOnCommand *command = notification.userInfo[@"command"];
  
    NSLog(@"Command received %@", command);
    
    // Set note mapping if recording
    if(self.isRecording) {
        
        // Handle mapping
        [self.receiveValue setValue: [NSNumber numberWithInteger:[command note]]];
        [self.velocitySlider setValue: [NSNumber numberWithInteger: [command velocity]]];
        
        [self setIsRecording: NO];
        
    } else if([self.receiveValue.value integerValue] == [command note]) {

    
        // Show/set velocity
        [self.velocitySlider setValue: [NSNumber numberWithInteger: [command velocity]]];
    
    }
    
    // If record
    

    
//     NSLog(@"Command received %@");
//
//    [command commandType];

//    if() {
//        
//    }
//    
//   
//    [self.data setObject: [NSNumber numberWithInt: [command velocity]] forKey: @"velocity"];
//    [self setActive: YES];
//    NSLog(@"Velocity %d", [command velocity]);
}


-(BOOL)active {
    return _active;
}

-(BOOL)isRecording {
    return _isRecording;
}

-(void)setIsRecording:(BOOL)isRecording {
    NSLog(@"Binding received");
    // Dispatch recording event
    if(isRecording) {
        [self.delegate startRecord: @{self.MIDIIdentifier : @"cc"}];
    }
    _isRecording = isRecording;
}

-(void)stopRecording:(NSNotification*)notification {
    NSLog(@"Stopping recording");
    [self.receiveRecordBtn setToggled: NO];
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
    _active = active;
}

@end

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
    
    self = [super initWithSize: NSMakeSize( MODULE_WIDTH / 2, 40)];
    
    if(!self) return nil;
    
    [self setFlipped: YES];
    
    self.data = data;
    
    _min = 0;
    _max = 127;
    _range = _max;
    
    NSLog(@"Self data: %@", self.data);
    
    /* Input */
    
    self.receiveRecordBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"receiveRecord"];
    [self.receiveRecordBtn setOrigin: NSMakePoint(0, 2)];
    [self.receiveRecordBtn setSendsEvent: NO];
    [self.receiveRecordBtn setIsToggle: YES];
    
    [self bind:@"isRecording" toObject:self.receiveRecordBtn withKeyPath:@"toggled" options:nil];
    
    [self addSubview: self.receiveRecordBtn];
    
    controlText *receiveValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"receiveNoteValue"]];
    uiNoteField *receiveNote = [[uiNoteField alloc] initWithString: [utilities noteName: [data[@"receiveNoteValue"] intValue] ]];
    
    [data bind:@"receiveNoteValue" toObject: receiveValue withKeyPath: @"value" options: nil];

    [receiveNote bind:@"noteValue" toObject: receiveValue withKeyPath: @"value" options: nil];
    [receiveNote bind:@"hidden" toObject: receiveValue.valueNumberField withKeyPath: @"isEditing" options: nil];

//    [self bind:@"receiveNotevalue" toObject:receiveValue withKeyPath:@"value" options:nil];
    
    [receiveValue setOriginWithX: 16 andY: 0];
    [receiveNote setOriginWithX: 16 andY: 0];
    
    [self addSubview: receiveValue ];
    [self addSubview: receiveNote ];
    
    /* Output */
    
    uiButton *sendRecord = [[uiButton alloc] initWithSize: 12 andEvent: @"sendRecord"];
    [sendRecord setOrigin: NSMakePoint(0, 20)];
    [sendRecord setIsToggle: YES];
    
    [self addSubview: sendRecord];
    
    controlText *noteValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"sendNoteValue"]];
    uiNoteField *note = [[uiNoteField alloc] initWithString:  [utilities noteName: [data[@"sendNotevalue"] intValue] ]];
    
    [data bind:@"sendNoteValue" toObject: noteValue withKeyPath: @"value" options: nil];
    //
    [note bind:@"noteValue" toObject: noteValue withKeyPath: @"value" options: nil];
    [note bind:@"hidden" toObject: noteValue.valueNumberField withKeyPath: @"isEditing" options: nil];

//    [self bind:@"sendNoteValue" toObject:receiveValue withKeyPath:@"value" options:nil];
    
    [noteValue setOriginWithX: 16 andY: 18];
    [note setOriginWithX: 16 andY: 18];
    
    [self addSubview: noteValue ];
    [self addSubview: note ];
    
    /* Velocity slider */
    
    controlSlider *velSlider = [[controlSlider alloc] initWithSize:NSMakeSize(12, self.frameHeight - 4) andValue: 0 andMinValue: 0 andMaxValue: 127];
    
    [velSlider setIsVertical: YES];
    
    [velSlider setOriginWithX: 38 andY: 2];
    
    [velSlider bind:@"value" toObject: self withKeyPath:@"velocity" options: nil];
    
    [self addSubview: velSlider];
    
    /* Trigger */
    
    NSSize padSize = NSMakeSize(40, 40);
    
    controlTrigger *trigger = [[controlTrigger alloc] initWithSize: padSize andValue: self.data[@"velocity"]];
    
    [trigger setOriginWithX: 52 andY: 2];
    
    [self bind:@"active" toObject: trigger withKeyPath:@"active" options: nil];
    
    [trigger bind:@"value" toObject: velSlider withKeyPath:@"value" options: nil];
    
    [self addSubview: trigger];
    
    /* Lock veolocity */
    
    uiButton *lockVelocity = [[uiButton alloc] initWithSize: 12 andEvent: @"lockVelocity"];
    [lockVelocity setOrigin: NSMakePoint(2, self.frameHeight - 12 )];
    
    [lockVelocity setIsToggle: YES];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {

}

//-(void)handleMIDICommand:(NSNotification*)notification {
//    
//     MIKMIDICommand *command = notification.userInfo[@"command"];
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
//}


-(BOOL)active {
    return _active;
}

-(BOOL)isRecording {
    return _isRecording;
}

-(void)setIsRecording:(BOOL)isRecording {
    NSLog(@"Binding received");
    // Dispatch recording event
    [self.delegate startRecord: self];
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

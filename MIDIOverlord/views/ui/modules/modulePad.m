//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

@synthesize inputValue = _inputValue;

-(id)initWithData: (NSMutableDictionary*)data{
    
    int height = 40;
    
    self = [super initWithHeight: height];
    
    if(!self) return nil;
    
    [self setFlipped: YES];
    
    self.data = data;
    
    _min = 0;
    _max = 127;
    _range = _max;
    _velocity = self.data[@"velocity"];
    
    NSLog(@"Self data: %@", self.data);
    
    /* Input */
    
    uiButton *listenRecord = [[uiButton alloc] initWithSize: 12 andEvent: @"midiListenRecord"];
    [listenRecord setOrigin: NSMakePoint(2, 2)];
    [listenRecord setIsToggle: YES];
    
    [self addSubview: listenRecord];
    
    controlText *inputValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"inputNote"]];
    uiNoteField *inputNote = [[uiNoteField alloc] initWithString: self.data[@"inputNoteString"]];
    
    [data bind:@"inputNote" toObject: inputValue withKeyPath: @"value" options: nil];
    
    [inputNote bind:@"noteValue" toObject: inputValue withKeyPath: @"value" options: nil];
    
    [inputNote setDrawBg: NO];
    
    [inputValue setOriginWithX: 18 andY: 0];
    [inputNote setOriginWithX: inputValue.frameWidth + 18 andY: 0];
    
    [self bind:@"inputValue" toObject:inputValue withKeyPath:@"value" options:nil];
    
    [self addSubview: inputValue ];
    [self addSubview: inputNote ];
    
    /* Output */
    
    uiButton *sendRecord = [[uiButton alloc] initWithSize: 12 andEvent: @"midiListenRecord"];
    [sendRecord setOrigin: NSMakePoint(2, 20)];
    [sendRecord setIsToggle: YES];
    
    [self addSubview: sendRecord];
    
    controlText *noteValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"note"]];
    uiNoteField *note = [[uiNoteField alloc] initWithString: self.data[@"noteString"]];
    
    [data bind:@"inputNote" toObject: inputValue withKeyPath: @"value" options: nil];
    
    [note bind:@"noteValue" toObject: noteValue withKeyPath: @"value" options: nil];
    
    [note setDrawBg: NO];
    
    [noteValue setOriginWithX: 18 andY: 18];
    [note setOriginWithX: inputValue.frameWidth + 18 andY: 18];
    
    [self bind:@"inputValue" toObject:inputValue withKeyPath:@"value" options:nil];
    
    [self addSubview: noteValue ];
    [self addSubview: note ];
    
    /* Trigger */
    
    NSSize padSize = NSMakeSize(RACK_WIDTH / 2, 10);
    
    controlTrigger *trigger = [[controlTrigger alloc] initWithSize: padSize andValue: self.data[@"velocity"]];
    
    [trigger setOriginWithX: 0 andY: 20];
    
//    [self addSubview: trigger];
    
    /* Velocity slider */
    
    /* Lock veolocity */
    
    uiButton *lockVelocity = [[uiButton alloc] initWithSize: 12 andEvent: @"lockVelocity"];
    [lockVelocity setOrigin: NSMakePoint(2, self.frameHeight - 12 )];
    
    [lockVelocity setIsToggle: YES];
    
//    [self addSubview: sendRecord];

//    
//
//    
//    self = [super initWithFrame:NSMakeRect(0, 0, size.width, size.height + _padNote.frameHeight + 2)];
//    
//    if(!self) return nil;
//    
//    _padNote = [[controlText alloc] initWithLabel: @"" andValue: noteValue];
//    
//    [_padNote setOrigin:NSMakePoint(0, 41)];
//    
//    [self bind:@"noteValue" toObject:_padNote withKeyPath:@"value" options:nil];
//    
//    _noteLabel = [[uiTextField alloc] initWithString: @"---" andMaxLength: 5 ];
//    _velocityLabel = [[uiTextField alloc] initWithString: [_velocity stringValue] andMaxLength: 3 ];
//    
//    [_velocityLabel setTextColor: [global sharedGlobalData].colors[@"white"] ];
//    
//    [_noteLabel setOriginWithX: 0 andY: 4];
//    [_velocityLabel setOriginWithX: 0 andY: 20];
//    
//    [_noteLabel setDrawBg: NO];
//    [_velocityLabel setDrawBg: NO];
//    
//    [self addSubview: _padNote];
//    
//    [self addSubview: _noteLabel];
//    [self addSubview: _velocityLabel];
//    
//    [self updateMarker];
//    
//    [self setNoteValue: noteValue];
    
    
    return self;
}


@end

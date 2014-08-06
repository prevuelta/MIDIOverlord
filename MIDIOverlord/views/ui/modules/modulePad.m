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
    
    self = [super initWithSize: NSMakeSize( MODULE_WIDTH / 2, 36)];
    
    if(!self) return nil;
    
    [self setFlipped: YES];
    
    self.data = data;
    
    _min = 0;
    _max = 127;
    _range = _max;
    _velocity = self.data[@"velocity"];
    
    NSLog(@"Self data: %@", self.data);
    
    /* Input */
    
    uiButton *listenRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"midiListenRecord"];
    [listenRecord setOrigin: NSMakePoint(0, 0)];
    [listenRecord setIsToggle: YES];
    
    [self addSubview: listenRecord];
    
    controlText *inputValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"inputValue"]];
    uiNoteField *inputNote = [[uiNoteField alloc] initWithString: [utilities noteName: [data[@"inputValue"] intValue] ]];
    
    [data bind:@"inputValue" toObject: inputValue withKeyPath: @"value" options: nil];
    
    [inputNote bind:@"noteValue" toObject: inputValue withKeyPath: @"value" options: nil];
    [inputNote bind:@"hidden" toObject: inputValue.valueNumberField withKeyPath: @"isEditing" options: nil];
    
    [inputValue setOriginWithX: 16 andY: 0];
    [inputNote setOriginWithX: 16 andY: 0];
    
    [self bind:@"inputValue" toObject:inputValue withKeyPath:@"value" options:nil];
    
    [self addSubview: inputValue ];
    [self addSubview: inputNote ];
    
    /* Output */
    
    uiButton *sendRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"midiListenRecord"];
    [sendRecord setOrigin: NSMakePoint(0, 18)];
    [sendRecord setIsToggle: YES];
    
    [self addSubview: sendRecord];
    
    controlText *noteValue = [[controlText alloc] initWithLabel: @"" andValue: data[@"outputValue"]];
    uiNoteField *note = [[uiNoteField alloc] initWithString:  [utilities noteName: [data[@"outputNote"] intValue] ]];
    
    [data bind:@"outputValue" toObject: noteValue withKeyPath: @"value" options: nil];
    
    [note bind:@"noteValue" toObject: noteValue withKeyPath: @"value" options: nil];
    [note bind:@"hidden" toObject: noteValue.valueNumberField withKeyPath: @"isEditing" options: nil];
    
    [noteValue setOriginWithX: 16 andY: 18];
    [note setOriginWithX: 16 andY: 18];
    
    [self bind:@"inputValue" toObject:inputValue withKeyPath:@"value" options:nil];
    
    [self addSubview: noteValue ];
    [self addSubview: note ];
    
    /* Trigger */
    
    NSSize padSize = NSMakeSize(26, self.frameHeight - 4);
    
    controlTrigger *trigger = [[controlTrigger alloc] initWithSize: padSize andValue: self.data[@"velocity"]];
    
    [trigger setOriginWithX: 52 andY: 2];
    
    [self addSubview: trigger];
    
    /* Velocity slider */
    
    controlSlider *velSlider = [[controlSlider alloc] initWithSize:NSMakeSize(8, self.frameHeight - 4) andValue: 0 andMinValue: 0 andMaxValue: 127];
    
    [velSlider setIsVertical: YES];
    
    NSLog(@"FW: %f", self.frameWidth);
    
    [velSlider setOriginWithX: 80 andY: 2];
    
    [self addSubview: velSlider];
    
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

-(void)drawRect:(NSRect)dirtyRect {
//       [[NSColor redColor] setFill];
//       NSRectFill(dirtyRect);
//      [super drawRect:dirtyRect];
}

@end

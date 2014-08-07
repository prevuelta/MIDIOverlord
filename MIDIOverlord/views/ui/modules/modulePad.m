//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

//@synthesize inputValue = _inputValue;

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
    
    uiButton *receiveRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"receiveRecord"];
    [receiveRecord setOrigin: NSMakePoint(0, 0)];
    [receiveRecord setIsToggle: YES];
    
    [self addSubview: receiveRecord];
    
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
    
    uiButton *sendRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"sendRecord"];
    [sendRecord setOrigin: NSMakePoint(0, 18)];
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
    
    /* Trigger */
    
    NSSize padSize = NSMakeSize(26, self.frameHeight - 4);
    
    controlTrigger *trigger = [[controlTrigger alloc] initWithSize: padSize andValue: self.data[@"velocity"]];
    
    [trigger setOriginWithX: 52 andY: 2];
    
    [self addSubview: trigger];
    
    /* Velocity slider */
    
    controlSlider *velSlider = [[controlSlider alloc] initWithSize:NSMakeSize(8, self.frameHeight - 4) andValue: 0 andMinValue: 0 andMaxValue: 127];
    
    [velSlider setIsVertical: YES];
    
    [velSlider setOriginWithX: 80 andY: 2];
    
    [trigger bind:@"value" toObject: velSlider withKeyPath:@"value" options: nil];
    
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

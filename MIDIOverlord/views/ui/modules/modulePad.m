//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

@synthesize currentNote = _currentNote;

-(id)initWithData: (NSMutableDictionary*)data{
    
    int height = 56;
    
    self = [super initWithHeight: height];
    
    if(!self) return nil;
    
    NSLog(@"Width: %d", self.width);
    
    self.data = data;
    
    NSPoint padSize = NSMakePoint(36, 36);
    
    controlPad *pad1 = [[controlPad alloc] initWithSize: padSize andValue: @2 andMinValue:0 andMaxValue:127];
    controlPad *pad2 = [[controlPad alloc] initWithSize: padSize andValue: @2 andMinValue:0 andMaxValue:127];
    controlPad *pad3 = [[controlPad alloc] initWithSize: padSize andValue: @2 andMinValue:0 andMaxValue:127];
    controlPad *pad4 = [[controlPad alloc] initWithSize: padSize andValue: @2 andMinValue:0 andMaxValue:127];
    
    [pad1 setOrigin:NSMakePoint(2, 2)];
    [pad2 setOrigin:NSMakePoint(42, 2)];
    [pad3 setOrigin:NSMakePoint(82, 2)];
    [pad4 setOrigin:NSMakePoint(122, 2)];

    [self addSubview: pad1];
    [self addSubview: pad2];
    [self addSubview: pad3];
    [self addSubview: pad4];
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12];
    [removeBtn setEvent:@"removeModule" withData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 20 - SCROLLER_WIDTH, 42)];
    [removeBtn setInEditView:YES];
    
    [self addSubview: removeBtn];

    return self;
    
}

-(NSString*)noteString:(int)noteNum {
    int octave = noteNum / 12 - 1;
    NSString *notes = @"C C#D D#E F F#G G#A A#B";
    NSString *note = [[notes substringFromIndex:(noteNum % 12) * 2] substringToIndex: (noteNum % 12) * 2 + 2];
    return [NSString stringWithFormat:@"%d%@", octave-1, note];
}

-(NSNumber*)currentNote {
    return _currentNote;
}

-(void)setCurrentNote:(NSNumber*)currentNote {
    _currentNote = currentNote;
}


@end
 
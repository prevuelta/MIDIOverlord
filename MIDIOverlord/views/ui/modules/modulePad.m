//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

@synthesize midiStatusByte= _midiStatusByte;

-(id)initWithData: (NSMutableDictionary*)data{
    
    int height = 38;
    
    int size = 32;
    
    NSRect frame = NSMakeRect(0, 0, 32, height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.height = height;
    
    self.data = data;
    
    
    NSPoint padSize = NSMakePoint(size, size);
    
    controlTrigger *pad = [[controlTrigger alloc] initWithFrame: padSize:
                            NSMakePoint(0, 0)];
    
    controlText *note = [[controlText alloc] initWithLabel:@""];
    [note setValue: @34];
    [note setInEditView: YES];
    [self addSubview: note];
    

    [self addSubview: pad];
    
    uiButtonClose *removeBtn = [[uiButtonClose alloc] initWithSize: 8];
    [removeBtn setEvent:@"removeModule" withData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 20 - SCROLLER_WIDTH, 2)];
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



@end
 
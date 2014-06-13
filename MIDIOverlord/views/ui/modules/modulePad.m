//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

@synthesize midiV1= _midiV1;

- (id)initWithFrame{
    
    int height = 38;
    
    NSRect frame = NSMakeRect(0, 0, RACK_WIDTH, height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.height = height;
    
    [self addCCField];
    
    _midiV1 = @122;
    
    int size = 32;
    
    NSPoint padSize = NSMakePoint(size, size);
    
    controlTrigger *pad1 = [[controlTrigger alloc] initWithFrame: padSize:
                            NSMakePoint(2, 2)];
    
    controlTrigger *pad2 = [[controlTrigger alloc] initWithFrame:padSize:
                            NSMakePoint(40, 2)];
 
    controlTrigger *pad3 = [[controlTrigger alloc] initWithFrame:padSize:
                            NSMakePoint(78, 2)];
    
    controlTrigger *pad4 = [[controlTrigger alloc] initWithFrame:padSize:
                            NSMakePoint(116, 2)];
    
    [self addSubview: pad1];
    [self addSubview: pad2];
    [self addSubview: pad3];
    [self addSubview: pad4];
    
    return self;
}



@end
 
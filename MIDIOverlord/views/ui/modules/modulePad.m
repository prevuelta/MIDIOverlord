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
    
    int height = 24;
    
    NSRect frame = NSMakeRect(0, 0, RACK_WIDTH, height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.height = height;
    
    [self addCCField];
    
    _midiV1 = 122;
    
    controlTrigger *pad = [[controlTrigger alloc] initWithFrame:NSMakePoint(16, 16): NSMakePoint(RACK_WIDTH - 24, 4)];
    
    [self addSubview: pad];
    
    return self;
}



@end
 
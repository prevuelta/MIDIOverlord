//
//  modulePad.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

@synthesize midiValue = _midiValue;

- (id)initWithFrame{
    
    int width = 80;
    
    NSRect frame = NSMakeRect(0, 0, width, RACK_HEIGHT );
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.width = width;
    
    _midiValue = 122;
    
    controlTrigger *pad = [[controlTrigger alloc] initWithFrame:NSMakePoint(self.width - 16, self.width - 16): NSMakePoint(8, 8)];
    
    pad.delegate = self;
    
    [self addSubview: pad];
    
    return self;
}



@end
 
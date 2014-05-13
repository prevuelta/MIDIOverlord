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
    
    int width = 80;
    
    NSRect frame = NSMakeRect(0, 0, width, MODULE_HEIGHT);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.width = width;
    
    _midiV1 = 122;
    
    controlTrigger *pad = [[controlTrigger alloc] initWithFrame:NSMakePoint(self.width - 16, self.width - 16): NSMakePoint(8, 8)];
    
//    pad.delegate = self;
    
    [self addSubview: pad];
    
    return self;
}



@end
 
//
//  controlPad.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

- (id)initWithFrame{
    
    NSRect frame = NSMakeRect(0, 0, 64, RACK_HEIGHT );
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.gridX = 2;
    self.gridY = 1;
    
    self.width = 64;
    
    _midiNote = 122;
    
    // Add UI buttons
    float padRGBA[] = DARK_GREY;
    NSColor* padColor = [utilities getNSColorFromRGB:padRGBA];
    
    uiButton *pad = [[uiButton alloc] initWithFrame:NSMakePoint(self.width - 16, self.width - 16): NSMakePoint(8, 8): padColor ];
    
    pad.delegate = self;
    
    [self addSubview: pad];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    
    float bgRGBA[] = LIGHT_OLIVE;

    NSColor* bgColor = [utilities getNSColorFromRGB:bgRGBA];
    
    [bgColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, RACK_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];
    
}

-(void)trigger:(int)type {
    [self sendTrigger:type:_midiNote];
}

@end
 
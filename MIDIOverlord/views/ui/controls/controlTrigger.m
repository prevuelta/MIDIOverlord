//
//  gmUIElement.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlTrigger.h"

@implementation controlTrigger

- (id)initWithFrame:(NSPoint)size :(NSPoint)offset {
    
    self = [super initWithFrame:NSMakeRect(offset.x, offset.y, size.x, size.y)];
    if(!self) return nil;

    _size = size;
    _offset = offset;

    // Setup colors
    float upRGBA[] = UI_COLOR_PROT_2;
    _upColor = [utilities getNSColorFromRGB:upRGBA];

    float downRGBA[] = UI_COLOR_PROT_3;
    _downColor = [utilities getNSColorFromRGB:downRGBA];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRect:NSMakeRect(0, 0, _size.x, _size.y)];
    
    [btnPath closePath];
    
    if(self.active) {
        [self.downColor set];
    } else {
        [self.upColor set];
    }
    
    [btnPath fill];
    
}

-(void)mouseDown:(NSEvent *)theEvent {
    self.active = true;
    [self setNeedsDisplay:YES];
    [self.delegate uiEvent:"noteOn"];
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = false;
    [self setNeedsDisplay:YES];
    [self.delegate uiEvent:"noteOff"];
}

@end

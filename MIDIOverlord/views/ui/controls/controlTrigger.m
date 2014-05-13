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

    [self setDefaults];
    
    _size = size;
    _offset = offset;
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRect:NSMakeRect(0, 0, _size.x, _size.y)];
    
    [btnPath closePath];
    
    if(self.active) {
        [self.activeColor set];
    } else {
        [self.defaultColor set];
    }
    
    [btnPath fill];
    
}

-(void)mouseDown:(NSEvent *)theEvent {
    self.active = YES;
    [self setNeedsDisplay:YES];
//    [self.delegate uiEvent:"noteOn"];
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = NO;
    [self setNeedsDisplay:YES];
//    [self.delegate uiEvent:"noteOff"];
}

@end

//
//  gmUIElement.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlTrigger.h"

@implementation controlTrigger

- (id)initWithSize:(NSPoint)size {
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.x, size.y)];
    if(!self) return nil;
    
    _size = size;
    
    uiText *label = [[uiText alloc] initWithString: @"---" andMaxLength: 3 andLabelLength: 3];
    
    [label setOrigin:NSMakePoint(2, 2)];
    
    [self addSubview: label];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, _size.x, _size.y) xRadius: 2 yRadius: 2];
    
    [btnPath closePath];
    
    if(self.active) {
        [[global sharedGlobalData].activeColor set];
    } else {
        [[global sharedGlobalData].bgColor set];
    }
    
    [btnPath fill];
    
}

-(void)mouseDown:(NSEvent *)theEvent {
    self.active = YES;
    [self setNeedsDisplay:YES];
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = NO;
    [self setNeedsDisplay:YES];
}

@end

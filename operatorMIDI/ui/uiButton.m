//
//  gmUIElement.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "uiButton.h"

@implementation uiButton

- (id)initWithFrame:(NSPoint)size :(NSPoint)offset :(NSColor*)bg {
    self = [super initWithFrame:NSMakeRect(offset.x, offset.y, size.x, size.y)];
    if(!self) return nil;
    
    _path = [NSBezierPath bezierPath];
    _size = size;
    _offset = offset;
    _bg = bg;
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRect:NSMakeRect(0, 0, _size.x, _size.y)];
    
    [btnPath closePath];

    [_bg set];
    
    [btnPath fill];
    
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"Clicked");
    [self delegate];
}

@end

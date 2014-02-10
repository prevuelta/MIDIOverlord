//
//  gmUIElement.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "uiButton.h"

@implementation uiButton

- (id)initWithFrame:(NSRect)frame :(NSPoint)size :(NSPoint)offset {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    _path = [NSBezierPath bezierPath];
    _size = size;
    _offset = offset;
    _bg = SKIN_BTN;
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRect:NSMakeRect(_offset.x, _offset.y, _size.x, _size.y)];
    
    [btnPath closePath];
    
    [[NSColor blackColor] set];
    
    [btnPath fill];
    
}

-(void)mouseDown:(NSEvent *)theEvent {
//    [self.delegate s]
}

@end

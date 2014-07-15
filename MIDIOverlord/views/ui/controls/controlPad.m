//
//  gmUIElement.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

-(id)initWithSize:(NSPoint)size andValue: (NSNumber*)value andMinValue:(int)min andMaxValue:(int)max {
    
    _size = size;
    _min = min;
    _max = max;
    _range = max - min;
    
    controlText *padNote = [[controlText alloc] initWithLabel: @"|" andValue:@-1];
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.x, size.y + padNote.frameHeight + 2)];
    if(!self) return nil;
    
    [padNote setOrigin:NSMakePoint(0, 38)];
    
    [self addSubview: padNote];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, _size.x, _size.y) xRadius: 1 yRadius: 1];
    
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

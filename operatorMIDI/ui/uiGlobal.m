//
//  uiGlobal.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiGlobal.h"

@implementation uiGlobal

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    [[NSColor blackColor] set];
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, WINDOW_WIDTH, TOOLBAR_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];
    
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

@end

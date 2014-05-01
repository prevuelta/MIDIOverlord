//
//  uiApp.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiApp.h"

@implementation uiApp

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    [[NSColor colorWithDeviceRed:83 green:83 blue:84 alpha:255] set];
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, WINDOW_WIDTH, TOOLBAR_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];
    
    controlText *appTitle = [[controlText alloc] initWithFrame: -1 andLabel: @"MIDI OVERLORD"];
    
    [appTitle setOrigin:NSMakePoint(0, 30)];
    
    [self addSubview: appTitle];
    
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

@end

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
    
    uiText *appTitle = [[uiText alloc] initWithString: @"MIDI OVERLORD PROTOTYPE V.001"];
    
//    [appTitle setGridCellSizeY:3];
//    [appTitle setupGridSystem];
    
//    [appTitle setNeedsDisplay:YES];
    
//    [appTitle setOrigin:NSMakePoint(0, 0)];
    
    [self addSubview: appTitle];
    
    // UI Buttons
    
    
    // Add rack
    uiButton *addRack = [[uiButton alloc] initWithFrame: 30];
    [addRack setOrigin: NSMakePoint(50, 0)];
    [addRack setEvent: @"addRack"];
    [self addSubview: addRack];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    [[NSColor colorWithDeviceRed:83 green:83 blue:84 alpha:255] set];
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, RACK_WIDTH * 4, TOOLBAR_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];

}

-(BOOL)isFlipped {
    return YES;
}

@end

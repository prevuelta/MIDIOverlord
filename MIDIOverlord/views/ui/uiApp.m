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
    
//    uiText *appTitle = [[uiText alloc] initWithString: @"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890`~!@#$%^&*()-=_+[]\{}|;':\",./<>?"];
    
    uiText *appTitle = [[uiText alloc] initWithString: @"MIDI OVERLORD PROTOTYPE V.002" andSize: @[@3, @3]];
//    [appTitle setDefaultColor:[NSColor whiteColor]];
//    [appTitle setMarkerColor:[NSColor blackColor]];
    [appTitle setGridCellSizeY:3];
    [appTitle setOrigin:NSMakePoint(4, 4)];
    
//    [appTitle setGridCellSizeY:3];
//    [appTitle setupGridSystem];
    
//    [appTitle setNeedsDisplay:YES];
    
//    [appTitle setOrigin:NSMakePoint(0, 0)];
    
    [self addSubview: appTitle];
    
    // UI Buttons
    
    
    // Add rack
    uiButton *addRack = [[uiButton alloc] initWithSize: 24];
    [addRack setOrigin: NSMakePoint(4, 20)];
    [addRack setEvent: @"addRack"];
    [self addSubview: addRack];
    
    uiButton *editMode = [[uiButton alloc] initWithSize: 24];
    [editMode setIsToggle: YES];
    [editMode setEvent: @"editMode"];
    [editMode setOrigin: NSMakePoint(32, 20)];
    
    [self addSubview: editMode];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
//    NSBezierPath* bgPath = [NSBezierPath new];
//    [[NSColor colorWithDeviceRed:83 green:83 blue:84 alpha:255] set];
//    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, RACK_WIDTH * 4, TOOLBAR_HEIGHT)];
//    [bgPath closePath];
//    [bgPath fill];

}

-(BOOL)isFlipped {
    return YES;
}

@end

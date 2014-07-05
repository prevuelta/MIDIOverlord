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
    NSImage *logo = [NSImage imageNamed:@"logo.png"];
    NSImageView *logoView = [[NSImageView alloc] initWithFrame:NSMakeRect(4, 0, 70, 52)];

    [logoView setImage:logo];
    
    [self addSubview:logoView];
    
    uiText *appTitle = [[uiText alloc] initWithString: @"MIDI OVERLORD PROTOTYPE V.002"];
    [appTitle setGridCellSizeY:3];
    [appTitle setOrigin:NSMakePoint(81, 4)];
    [appTitle setDrawBg: NO];
    
    [self addSubview: appTitle];
    
    // UI Buttons
    
    
    // Icon
    
    // Add rack
    uiButton *addRack = [[uiButton alloc] initWithSize: 24 andEvent: @"addRack"];
    [addRack setOrigin: NSMakePoint(81, 24)];

    [self addSubview: addRack];
    
    
    uiButton *editMode = [[uiButton alloc] initWithSize: 24 andEvent: @"editMode"];
    [editMode setIsToggle: YES];
    [editMode setOrigin: NSMakePoint(109, 24)];
    
    
    
    [self addSubview: editMode];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    [[global sharedGlobalData].bgColor set];
    [bgPath appendBezierPathWithRect: self.frame];
    [bgPath closePath];
    [bgPath fill];

}

-(BOOL)isFlipped {
    return YES;
}

-(void)resizeWidth:(int)newWidth {
    NSRect f = self.frame;
    f.size.width = newWidth;
    [self setFrame:f];
    [self setNeedsDisplay:YES];
}


@end

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
    
    uiText *appTitle = [[uiText alloc] initWithString: @"MIDI OVERLORD PROTOTYPE V.002" andSize: @[@3, @3]];
    [appTitle setGridCellSizeY:3];
    [appTitle setOrigin:NSMakePoint(81, 4)];
    
    [self addSubview: appTitle];
    
    // UI Buttons
    
    
    // Icon
    NSArray *rackIcon = @[@2, @100, @1, @100, @5, @6, @10, @50, @155, @11];
    
    // Add rack
    uiButton *addRack = [[uiButton alloc] initWithSize: 24 andIconArray: rackIcon];
    [addRack setOrigin: NSMakePoint(81, 24)];
    
    [addRack setEvent: @"addRack"];
    [self addSubview: addRack];
    
    NSArray *editIcon = @[@4, @20, @4, @16, @16, @4, @20, @8, @8, @20];
    
    uiButton *editMode = [[uiButton alloc] initWithSize: 24 andIconArray: editIcon];
    [editMode setIsToggle: YES];
    [editMode setEvent: @"editMode"];
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

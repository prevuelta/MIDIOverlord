//
//  uiApp.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiToolBar.h"

@implementation uiToolBar

- (id)initWithFrame:(NSRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
//    uiTextField *appTitle = [[uiTextField alloc] initWithString: @"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890`~!@#$%^&*()-=_+[]\{}|;':\",./<>?"];
//    NSImage *logo = [NSImage imageNamed:@"logo.png"];
//    NSImageView *logoView = [[NSImageView alloc] initWithFrame:NSMakeRect(4, 0, 70, 52)];
//
//    [logoView setImage:logo];
    
//    [self addSubview:logoView];
    

    
    // UI Buttons
    
    
    // Icon
    
    // Add rack
    uiButton *addRack = [[uiButton alloc] initWithSize: 24 andEvent: @"addRack"];
    [addRack setOrigin: NSMakePoint(4, 4)];

    [self addSubview: addRack];
    
    
    uiButton *editMode = [[uiButton alloc] initWithSize: 24 andEvent: @"editMode"];
    [editMode setIsToggle: YES];
    [editMode setOrigin: NSMakePoint(32, 4)];
    
    
    
    [self addSubview: editMode];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
//    NSBezierPath* bgPath = [NSBezierPath new];
//    [[global sharedGlobalData].darkBrown set];
//    [btnPath appendBezierPathWithRoundedRect:dirtyRect xRadius: 2 yRadius:2];
//    [bgPath appendBezierPathWithRoundedRect: NSMakeRect(2, 2, self.frameWidth - 4, self.frameHeight - 2) xRadius: 2 yRadius: 2];
//    [bgPath closePath];
//    [bgPath fill];

}

-(BOOL)isFlipped {
    return YES;
}


@end

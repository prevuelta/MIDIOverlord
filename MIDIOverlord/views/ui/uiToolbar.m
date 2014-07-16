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
    
    // Add rack
    uiButton *addControlRack = [[uiButton alloc] initWithSize: 24 andEvent: @"addControlRack"];
    [addControlRack setOrigin: NSMakePoint(4, 4)];

    [self addSubview: addControlRack];
    
    uiButton *addMapRack = [[uiButton alloc] initWithSize: 24 andEvent: @"addMapRack"];
    [addMapRack setOrigin: NSMakePoint(32, 4)];
    
    [self addSubview: addMapRack];
    
//    uiButton *editMode = [[uiButton alloc] initWithSize: 24 andEvent: @"editMode"];
//    [editMode setIsToggle: YES];
//    [editMode setOrigin: NSMakePoint(32, 4)];
//    
//    
//    [self addSubview: editMode];
    
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

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
    [addControlRack setOrigin: NSMakePoint(2, 2)];

    [self addSubview: addControlRack];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    [[global sharedGlobalData].colors[@"darkGrey"] setFill];
    NSRectFill(dirtyRect);

}

-(BOOL)isFlipped {
    return YES;
}


@end

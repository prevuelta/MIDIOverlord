//
//  controlOption.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlOption.h"

@implementation controlOption

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
        // Initialization code here.
    
    uiLabel = [uiLabel alloc] init
    
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(void)mouseMoved:(NSEvent *)theEvent{
    NSLog(@"Mouse entered");
    [self setBackgroundColor: _markerColor];
    [self setTextColor:_activeColor];
    [self setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
    [self setBackgroundColor: _defaultColor];
    [self setNeedsDisplay:YES];
}

-(void)setStringValue {
    label = [[controlOption alloc] initWithFrame: NSMakeRect(0, 2 * self.height, self.width, self.height)];
    [label setStringValue: @"All"];
    [self addSubview:label];
}

@end

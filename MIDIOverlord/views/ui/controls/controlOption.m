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
    
    [self setDefaults];
    
    _label = [[uiLabel alloc] initWithFrame: frame];
    [_label setDrawsBackground:YES];
    [self addSubview:_label];
    
    NSTrackingAreaOptions mouseEnterExitOptions = NSTrackingActiveInActiveApp;
    mouseEnterExitOptions |= NSTrackingMouseEnteredAndExited;
    
    NSTrackingArea *trackRect = [[NSTrackingArea alloc] initWithRect:frame options:mouseEnterExitOptions owner:self userInfo: nil];
    [self addTrackingArea: trackRect ];
    
    
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
//    [[NSColor whiteColor] setFill];
//     NSRectFill(dirtyRect);
//	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(void)mouseEntered:(NSEvent *)theEvent{
    NSLog(@"Mouse entered");
//  [_label setBackgroundColor:self.markerColor];
    [_label setTextColor:self.activeColor];
//    [_label setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
    NSLog(@"Mouse exited");
    [_label setBackgroundColor: self.activeColor];
    [_label setTextColor:self.markerColor];
//    [_label setNeedsDisplay:YES];
}

-(void)setStringValue:(NSString*)str {
    [_label setStringValue: str];
}

@end

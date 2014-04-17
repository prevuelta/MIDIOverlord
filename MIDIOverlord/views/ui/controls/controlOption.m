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
    
    _value = 0;
    
    _label = [[uiLabel alloc] initWithFrame: frame];
    [_label setBackgroundColor:self.defaultColor];
    [_label setDrawsBackground:YES];
    
    [self addSubview:_label];
    
    NSTrackingAreaOptions mouseEnterExitOptions = NSTrackingActiveInActiveApp;
    mouseEnterExitOptions |= NSTrackingMouseEnteredAndExited;
    
    NSTrackingArea *trackRect = [[NSTrackingArea alloc] initWithRect:frame options:mouseEnterExitOptions owner:self userInfo: nil];
    [self addTrackingArea: trackRect ];
    
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
    [[NSColor whiteColor] setFill];
     NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];

    // Drawing code here.
}

-(void)mouseEntered:(NSEvent *)theEvent{
  [_label setBackgroundColor:self.markerColor];
//    [_label setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
    [_label setBackgroundColor: self.defaultColor];
    [_label setTextColor:self.markerColor];
//    [_label setNeedsDisplay:YES];
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"Option clicked");
    [self.delegate uiEvent:"optionSelected" withInt: _value];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
}

-(void)setStringValue:(NSString*)str {
//    NSLog("%@", str);
    [_label setStringValue: @"dsdfSF"];
}

@end

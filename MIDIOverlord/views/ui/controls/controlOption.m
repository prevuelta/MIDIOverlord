//
//  controlOption.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlOption.h"

@implementation controlOption

@synthesize keyValue = _keyValue;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
        // Initialization code here.
    
    [self setDefaults];
    
    _label = [[uiLabel alloc] initWithFrame:frame];
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
//    [[NSColor whiteColor] setFill];
//     NSRectFill(dirtyRect);
//    [super drawRect:dirtyRect];
    if(self.selected) {
        [_label setBackgroundColor: self.activeColor];
    }

    // Drawing code here.
}

-(void)mouseEntered:(NSEvent *)theEvent{
//  [_label setBackgroundColor:self.activeColor];
  [_label setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
//    [_label setBackgroundColor: self.defaultColor];
//    [_label setTextColor:self.markerColor];
    [_label setNeedsDisplay:YES];
}

-(void)mouseDown:(NSEvent *)theEvent {
    [_label setBackgroundColor:self.activeColor];
    [self performSelector:@selector(selectOption) withObject:self afterDelay:0.150];
}

-(void)selectOption {
    NSLog(@"Sending dlegate...");
    [_label setBackgroundColor:self.defaultColor];
    [self.delegate optionSelectedWithKeyValue:self.keyValue andTag: self.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
   
}

-(NSArray*)keyValue {
    return _keyValue;
}

-(void)setKeyValue:(NSArray*)keyValue{
//    NSLog("%@", str);
    _keyValue = keyValue;
    [_label setStringValue: keyValue[0]];
}

@end

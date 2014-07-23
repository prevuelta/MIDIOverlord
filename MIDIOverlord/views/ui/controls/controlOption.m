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

- (id)initWithKeyValue: (NSArray*)keyValue {
    _label = [[uiTextField alloc] initWithString: keyValue[1] andMaxLength: 11];
    
    self = [super initWithFrame:_label.frame];
    
    if (!self) return nil;
    
    _keyValue = keyValue;
    
    NSLog(@"optionString: %@", keyValue[1]);
    
    [_label setDrawBg:YES];
    
    [self addSubview:_label];
    
    NSTrackingAreaOptions mouseEnterExitOptions = NSTrackingActiveInActiveApp;
    mouseEnterExitOptions |= NSTrackingMouseEnteredAndExited;
    
    NSTrackingArea *trackRect = [[NSTrackingArea alloc] initWithRect:_label.frame options:mouseEnterExitOptions owner:self userInfo: nil];
    
    [self addTrackingArea: trackRect ];
    
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
//   [[NSColor whiteColor] setFill];
//   NSRectFill(dirtyRect);
//  [super drawRect:dirtyRect];
    if(self.selected) {
//        [_label setBackgroundColor: self.activeColor];
    }

    // Drawing code here.
}

-(void)mouseEntered:(NSEvent *)theEvent{
    NSLog(@"Mouse entered");
  [_label setBgColor:[global sharedGlobalData].activeColor];
  [_label setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
//    [_label setBackgroundColor: self.defaultColor];
    [_label setBgColor:[global sharedGlobalData].black];
    [_label setNeedsDisplay:YES];
}

-(void)mouseDown:(NSEvent *)theEvent {
//    [_label setBackgroundColor: [global sharedGlobalData].activeColor];
//    [self performSelector:@selector(selectOption) withObject:self afterDelay:0.150];
    [self selectOption];
}

-(void)selectOption {
    NSLog(@"Sending delegate...");
//    [_label setBackgroundColor:self.activeColor];
    [self.delegate setSelectedIndex: self.keyValue[0]];
    [global deselectNotify];
   
}

@end

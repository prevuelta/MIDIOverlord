//
//  controlOption.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlOption.h"

@implementation controlOption

- (id)initWithName: (NSString*)name andIndex:(int)index{
    _label = [[uiTextField alloc] initWithString: name andMaxLength: 11];
    
    self = [super initWithFrame:_label.frame];
    
    if (!self) return nil;
    
    [_label setDrawBg:YES];
    
    [self addSubview:_label];
    
    _index = index;
    
    NSTrackingAreaOptions mouseEnterExitOptions = NSTrackingActiveInActiveApp;
    mouseEnterExitOptions |= NSTrackingMouseEnteredAndExited;
    
    NSTrackingArea *trackRect = [[NSTrackingArea alloc] initWithRect:_label.frame options:mouseEnterExitOptions owner:self userInfo: nil];
    
    [self addTrackingArea: trackRect ];
    
    /* Colors */
    
    [self setDisabledColor: [global sharedGlobalData].colors[@"blue"]];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
//   [[NSColor whiteColor] setFill];
//   NSRectFill(dirtyRect);
//  [super drawRect:dirtyRect];
    if(self.selected) {
//        [_label setBackgroundColor: self.activeColor];
    }
    
    
    if(self.disabled) {
        [_label setBgColor: self.disabledColor];
    }

    // Drawing code here.
}

-(void)mouseEntered:(NSEvent *)theEvent{
    NSLog(@"Mouse entered");
    [_label setBgColor:[global sharedGlobalData].colors[@"red"]];
    [_label setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
//    [_label setBackgroundColor: self.defaultColor];
    [_label setBgColor:[global sharedGlobalData].colors[@"lightGrey"]];
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
    [self.delegate setSelectedIndex: self.index];
    [global deselectNotify];
   
}

@end

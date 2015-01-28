//
//  gmUIElement.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlTrigger.h"

@implementation controlTrigger

@synthesize value = _value;

-(id)initWithSize:(NSSize)size andValue: (NSNumber *)value {
    
    _size = size;
    _value = value;
    
    _min = 0;
    _max = 127;
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.width, size.height)];
    
    if(!self) return nil;
    
    // Colors
    _activeColor = [global sharedGlobalData].colors[@"pink"];
    _defaultColor = [global sharedGlobalData].colors[@"white"];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* markerPath = [NSBezierPath new];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, _size.width, _size.height)];
    
    [self.defaultColor setFill];
    
    [bgPath fill];
    
    [markerPath appendBezierPathWithOvalInRect: NSMakeRect(0, 0, _size.width, _size.height)];
    
//    if(self.active) {
        [[self.activeColor colorWithAlphaComponent: [_value floatValue] / _max ] setFill];
//    } else {
//        [self.defaultColor setFill];
//    }
    
    if(self.active) return;
    
    [markerPath fill];
}

-(void)setValue:(NSNumber *)value {
    _value = value;
    NSLog(@"setvalue");
    [self setNeedsDisplay: YES];
}

-(NSNumber*)value {
    return _value;
}

-(void)mouseDown:(NSEvent *)theEvent {
    self.active = YES;
    [self setNeedsDisplay:YES];
}

-(void)mouseDragged:(NSEvent*)e {
    NSLog(@"Dragged");
    if(self.active){
//        [self updateControlFromEvent:e];
    }
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = NO;
    [self setNeedsDisplay:YES];
}



-(void)updateControlFromEvent:(NSEvent*)e {
    
    NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
//    
//    float percent = location.y / _size.y;
//    int newValue =  percent < 0 ? _min : percent > 1 ? _max : floor(_range * percent);
//    
//    [self setVelocity: [NSNumber numberWithInt: newValue]];
    
    [self setNeedsDisplay:YES];
    
}


@end

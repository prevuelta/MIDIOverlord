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
@synthesize active = _active;

-(id)initWithSize:(NSSize)size andValue: (NSNumber *)value {
    
    _size = size;
    _value = value;
    
    _min = 0;
    _max = 127;
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.width, size.height)];
    
    if(!self) return nil;
    
    // Colors
    self.activeColor = [global sharedGlobalData].colors[@"red"];
    self.defaultColor = [global sharedGlobalData].colors[@"black"];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* markerPath = [NSBezierPath new];
    
//    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, _size.width, _size.height)];
    
    [bgPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, _size.width, _size.height) xRadius: 2 yRadius: 2];
    
    [self.defaultColor setFill];
    
    [bgPath fill];
    
    [markerPath appendBezierPathWithOvalInRect: NSMakeRect(0, 0, _size.width, _size.height)];
    
    if(!self.active) {
        [[self.activeColor colorWithAlphaComponent: [_value floatValue] / _max ] setFill];
    } else {
        [self.defaultColor setFill];
    }
    
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
    [self setActive: YES];
}

-(void)mouseUp:(NSEvent *)theEvent {
    [self setActive: NO];
}

-(BOOL)active {
    return _active;
}

-(void)setActive:(BOOL)active {
    _active = active;
    [self setNeedsDisplay: YES];
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

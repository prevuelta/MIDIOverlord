//
//  controlDial.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlDial.h"

@implementation controlDial

@synthesize value = _value;

-(id)initWithSize:(int)size andValue: (NSNumber*)value {
    return [self initWithSize: size andValue:value andMinValue: 0 andMaxValue: 127];
}

-(id)initWithSize:(int)size andValue: (NSNumber*)value andMinValue: (int)min andMaxValue: (int)max {
    self = [self initWithFrame:NSMakeRect(0, 0, size, size)];
    if(!self) return nil;
    
    _value = value;
    _min = min;
    _max = max;
    _range = max - min;
    _size = size;
    
    return self;
}

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.defaultColor = [global sharedGlobalData].colors[@"white"];
    self.markerColor = [global sharedGlobalData].colors[@"pink"];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
    
    [self.defaultColor setFill];
    
    NSBezierPath *markerPath = [NSBezierPath new];
    NSBezierPath *bgPath = [NSBezierPath new];

    float halfSize = _size / 2;
    
    NSPoint centerPoint = NSMakePoint(halfSize, halfSize);
    
    [bgPath appendBezierPathWithArcWithCenter:centerPoint radius: halfSize startAngle: 360 endAngle: 0 clockwise:YES];
    [bgPath appendBezierPathWithArcWithCenter:centerPoint radius: halfSize / 2 startAngle: 0 endAngle: 360 clockwise:NO];
    
    [bgPath fill];
    
    [self.markerColor setFill];
    
    float valueAngle = ([self.value floatValue] / 127) * 360;
    
    [markerPath appendBezierPathWithArcWithCenter:centerPoint radius: 10 startAngle: 270 endAngle: 270 - valueAngle clockwise:YES];
    
    [markerPath appendBezierPathWithArcWithCenter:centerPoint radius: halfSize startAngle: 270 - valueAngle endAngle: 270 clockwise: NO];

    
    [markerPath fill];
	
    // Drawing code here.
}

-(NSNumber*)value {
    return _value;
}

-(void)setValue:(NSNumber*)value {
    _value = value;
    [self setNeedsDisplay:YES];
}


-(void)mouseDown:(NSEvent *)e {
    [global deselectNotify];
    self.active = true;
    self.initialPoint =  [self convertPoint:[e locationInWindow] fromView:nil];
//    [self updateControlFromEvent:e];
}

- (void)mouseDragged:(NSEvent*)e {
    if(self.active){
        [self updateControlFromEvent:e];
    }
}

-(void)mouseUp:(NSEvent *)e {
    self.active = false;
    [self updateControlFromEvent:e];
}

-(void)updateControlFromData:(NSNumber*)value {
    [self setValue: value];
}

-(void)updateControlFromEvent:(NSEvent*)e {
    
    NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
    
//    float percent = location.y / _size;
//
//    int newValue =  percent < 0 ? _min : percent > 1 ? _max : floor(_range * percent);
    
    float difference = (location.y - self.initialPoint.y ) / 2;
    
    self.initialPoint = location;
    
    NSLog(@"%f", difference);
    
    float newRaw = [self.value intValue] + difference;
    
    float newValue = newRaw < 0 ? _min : newRaw > _max ? _max : [self.value floatValue] + difference;
    
    [self setValue: [NSNumber numberWithFloat: newValue]];
    
    [self setNeedsDisplay:YES];
    
}

@end

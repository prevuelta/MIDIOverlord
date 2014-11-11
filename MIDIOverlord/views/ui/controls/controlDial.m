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
    
    _relative = NO;
    
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
    
    [bgPath appendBezierPathWithArcWithCenter:centerPoint radius: halfSize startAngle: 300 endAngle: 240 clockwise:NO];
    [bgPath appendBezierPathWithArcWithCenter:centerPoint radius: halfSize / 2 startAngle: 240 endAngle: 300 clockwise:YES];
    
    [bgPath fill];
    
    [self.markerColor setFill];
    
    float valueAngle = ([self.value floatValue] / 127) * 300;
    
    [markerPath appendBezierPathWithArcWithCenter:centerPoint radius: 10 startAngle: 240 endAngle: 240 - valueAngle clockwise:YES];
    
    [markerPath appendBezierPathWithArcWithCenter:centerPoint radius: halfSize startAngle: 240 - valueAngle endAngle: 240 clockwise: NO];

    
    [markerPath fill];
	
    // Drawing code here.
}

-(NSNumber*)value {
    return _value;
}

-(void)setValue:(NSNumber*)value {
    _value = value;
    NSLog(@"%@", value);
    [self setNeedsDisplay:YES];
}


-(void)mouseDown:(NSEvent *)e {
    [global deselectNotify];
    self.active = true;
    if(!self.relative) {
        self.initialPoint =  [self convertPoint:[e locationInWindow] fromView:nil];
    }
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
    
    int newValue;
    
    if(self.relative) {

        float percent = location.y / _size;
        newValue =  percent < _min ? _min : percent > 1 ? _max : floor(_range * percent);
    
    } else {
        
        float difference = (location.y - self.initialPoint.y ) / 2;

        NSLog(@"%f", difference);
        
        self.initialPoint = location;
        
        int newRaw = [self.value intValue] + difference;
        
        newValue = newRaw <= _min ? _min : newRaw >= _max ? _max : [self.value intValue] + difference;
    }
    
    [self setValue: [NSNumber numberWithInt: newValue]];
    
    [self setNeedsDisplay:YES];
    
}

@end

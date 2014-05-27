//
//  controlSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlSlider.h"

int base;
int baseMarker;

@implementation controlSlider

@synthesize value = _value;
@synthesize marker = _marker;

-(id)initWithFrame:(NSPoint)size :(NSPoint)offset :(int)min :(int)max{
    
    self = [super initWithFrame:NSMakeRect(offset.x, offset.y, size.x, size.y)];
    if(!self) return nil;
    
    [self setDefaults];
    
    _size = size;
    _offset = offset;
    _min = min;
    _max = max;
    _range = max - min;
    self.active = false;
    
    _value = _min;
    
    _marker = _value;
                
    _textVal = [[controlText alloc] initWithFrame: _value andLabel: @"" andMaxVal: _max];
    
    [_textVal bind:@"value" toObject:self withKeyPath:@"self.value" options: nil];

    
//    _textVal = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0 , 48, 32)];
//    
//    [_textVal setBezeled:NO];
//    [_textVal setDrawsBackground:NO];
//    [_textVal setEditable:NO];
//    [_textVal setSelectable:NO];
//    
//    [_textVal setIntValue: _value];
//
    [self addSubview: _textVal];
//
    return self;
    
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* markerPath = [NSBezierPath new];
    
    [self.defaultColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.size.x, self.size.y)];
    [bgPath closePath];
    [bgPath fill];
    
    [self.markerColor set];
    
    [markerPath appendBezierPathWithRect:NSMakeRect(0, 0, self.marker, self.size.x)];
    [markerPath closePath];
    [markerPath fill];
    
}

-(void)setValue:(int)xLoc {
    float percent = xLoc / _size.x;
    _value = percent < 0 ? _min : percent > 1 ? _max : (int) _range * percent;
}

-(int)marker {
    return _marker;
}

-(void)setMarker:(int)marker {
    _marker =marker;
}

-(int)value {
    return _value;
}

-(void)mouseDown:(NSEvent *)e {
    self.active = true;
    [self updateControlFromEvent:e];
}

- (void)timerFireMethod:(NSTimer *)timer {
//      [self updateControlFromEvent:e];
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
     
 -(void)updateControlFromEvent:(NSEvent*)e {
     
     NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
     
     int newValue = location.x;

     
     
//     NSLog(@"%@, %@, %@ %@", [NSNumber numberWithInt: baseDiff], [NSNumber numberWithInt: newValue], [NSNumber numberWithInt: newValue], [NSNumber numberWithInt: _marker]);
////     
     [self setMarker: newValue];
     [self setValue: newValue];
     
     [self setNeedsDisplay:YES];
     
 }


@end

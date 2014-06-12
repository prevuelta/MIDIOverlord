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
    
    _size = size;
    _offset = offset;
    _min = min;
    _max = max;
    _range = max - min;
    
    [self setActive: NO];
    
    _value = [NSNumber numberWithInt: _min];
    
    _marker = [_value intValue];
                
    _textVal = [[uiText alloc] initWithString: [NSString stringWithFormat:@"%03d", [_value intValue]]];
    [_textVal setOrigin:NSMakePoint(RACK_WIDTH - 33, 2)];
    
    uiText *label = [[uiText alloc] initWithString: @"Resonance" andMaxLength: 4 andLabelLength: 2];
    
    [label setOrigin:NSMakePoint(2, 2)];

    // Setup cc
//    uiText *label = [[uiText alloc] initWithString: @"Resonance" andMaxLength: 4 andLabelLength: 4];
//    [label setOrigin:NSMakePoint(2, 2)];
    
    [self addSubview:label];
    
//    [_textVal bind:@"stringValue" toObject:self withKeyPath:@"self.value" options: nil];

    
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

-(void)setValue:(NSNumber*)value {
    [self.textVal setStringValue: [NSString stringWithFormat:@"%03d", [value intValue]]];
    _value = value;
   
}

-(int)marker {
    return _marker;
}

-(void)setMarker:(int)marker {
    _marker = marker;
}

-(NSNumber*)value {
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

-(void)updateControlFromData:(NSNumber*)value {
    float percent = [value floatValue] / (float)_range;
    NSLog(@"Percent: %@", [NSNumber numberWithFloat:percent]);
    [self setMarker: _size.x * percent];
    [self setValue: value];
}
-(void)updateControlFromEvent:(NSEvent*)e {
     
     NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];

     float percent = location.x / _size.x;
     int newValue =  percent < 0 ? _min : percent > 1 ? _max : (int) _range * percent;
     
     [self setMarker: location.x];
     [self setValue: [NSNumber numberWithInt: newValue]];
     
     [self setNeedsDisplay:YES];
     
 }


@end

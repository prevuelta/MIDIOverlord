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

-(id)initWithSize:(NSSize)size andValue: (NSNumber*)value andMinValue:(int)min andMaxValue:(int)max {
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.width, size.height)];
    
    if(!self) return nil;
    
    _size = size;
    _min = min;
    _max = max;
    _range = max - min;
    
    _isVertical = NO;
    
    [self setActive: NO];
    
    _value = value;
    
    [self updateMarker];
    
    _textVal = [[uiTextField alloc] initWithString: [NSString stringWithFormat:@"%03d", [_value intValue]]];
    [_textVal setOrigin:NSMakePoint(RACK_WIDTH - 36 - SCROLLER_WIDTH, 0)];
    [_textVal setDrawBg: NO];
    [_textVal setTextColor:[NSColor whiteColor]];
    
    [self addSubview: _textVal];
    
    self.defaultColor = [global sharedGlobalData].colors[@"darkGrey"];
    self.markerColor = [global sharedGlobalData].colors[@"yellow"];
    
    return self;
    
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* markerPath = [NSBezierPath new];
    
    [self.defaultColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.size.width, self.size.height)];
    [bgPath fill];
    
    [self.markerColor set];
    
    if(_isVertical) {
        [markerPath appendBezierPathWithRect:NSMakeRect(0, 0, self.size.width, self.marker)];
    } else {
        [markerPath appendBezierPathWithRect:NSMakeRect(0, 2, self.marker, self.size.height - 4 )];
    }
    [markerPath fill];
    
}

-(NSNumber*)value {
    return _value;
}

-(void)setValue:(NSNumber*)value {
    [self.textVal setStringValue: [NSString stringWithFormat:@"%03d", [value intValue]]];
    _value = value;
    [self updateMarker];
}

-(int)marker {
    return _marker;
}

-(void)setMarker:(int)marker {
    NSLog(@"%@", [NSNumber numberWithInt: marker]);
    _marker = marker;
}

-(void)updateMarker {
    float percent = [_value floatValue] / (float) self.range;
    NSLog(@"Slider value: %@ Percent: %f", _value, percent);
    int newValue = floor((_isVertical ? _size.height : _size.width) * percent);
    [self setMarker: newValue];
    [self setNeedsDisplay:YES];
}

-(void)mouseDown:(NSEvent *)e {
    [global deselectNotify];
    self.active = true;
    [self updateControlFromEvent:e];
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

-(void)mouseEntered:(NSEvent *)theEvent{
    NSLog(@"mouse entered");
//  [_label setDefaultColor:[global sharedGlobalData].activeColor];
//    [_label setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
//    [_label setBackgroundColor: self.defaultColor];
//    [_label setActiveColor:[global sharedGlobalData].markerColor];
//    [_label setNeedsDisplay:YES];
}


-(void)updateControlFromData:(NSNumber*)value {
    [self setValue: value];
}
-(void)updateControlFromEvent:(NSEvent*)e {
     
     NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];

     float percent = _isVertical ? location.y / _size.height : location.x / _size.width;
     int newValue =  percent < 0 ? _min : percent > 1 ? _max : floor(_range * percent);
    
     [self setValue: [NSNumber numberWithInt: newValue]];

     [self setNeedsDisplay:YES];
     
 }


@end

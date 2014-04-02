//
//  controlSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlSlider.h"

@implementation controlSlider

@synthesize value = _value;

-(id)initWithFrame:(NSPoint)size :(NSPoint)offset :(NSColor*)sliderBg :(int)min :(int)max{
    
    self = [super initWithFrame:NSMakeRect(offset.x, offset.y, size.x, size.y)];
    if(!self) return nil;
    
    _size = size;
    _offset = offset;
    _min = min;
    _max = max;
    _range = max - min;
    self.active = false;
    
    _value = _min;
    
    _marker = _value;
    
    _textVal = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0 , 48, 32)];
    
    [_textVal setBezeled:NO];
    [_textVal setDrawsBackground:NO];
    [_textVal setEditable:NO];
    [_textVal setSelectable:NO];
    
    [_textVal setIntValue: _value];
    
    [self addSubview: _textVal];
    
    return self;
    
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* markerPath = [NSBezierPath new];
    
    float bgRGBA[] = UI_COLOR_PROT_2;
    float markerRGBA[] = UI_COLOR_PROT_3;
    
    NSColor* bgColor = [utilities getNSColorFromRGB:bgRGBA];
    NSColor* markerColor = [utilities getNSColorFromRGB:markerRGBA];
    
    [bgColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.size.x, self.size.y)];
    [bgPath closePath];
    [bgPath fill];
    
    [markerColor set];
    
    [markerPath appendBezierPathWithRect:NSMakeRect(0, 0, self.size.x, self.marker)];
    [markerPath closePath];
    [markerPath fill];
    
}

-(void)setValue:(int)yLoc {
    float percent = yLoc / _size.y;
    _value = percent < 0 ? _min : percent > 1 ? _max : (int) _range * percent;
    [self.delegate uiEvent:"sliderVal" withInt:(int)_value];
    [self.textVal setIntValue: _value];
}

-(int)value {
    return _value;
}

-(void)mouseDown:(NSEvent *)e {
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
     
 -(void)updateControlFromEvent:(NSEvent*)e {
     NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
     self.marker = location.y;
     [self setNeedsDisplay:YES];
     [self setValue:(int)location.y];
 }


@end

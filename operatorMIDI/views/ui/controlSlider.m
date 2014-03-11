//
//  controlSlider.m
//  operatorMIDI
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
    _active = false;
    
    _value = _min;
    
    _marker = 20;
    
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
    
    int percent = yLoc / _size.y;
    
    NSLog(@"Set val raw: %d", _size.y);
    _value = _range * percent;
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
     [self setValue:location.y];
     [self.delegate uiEvent:"sliderVal" withInt:_value];
 }


@end

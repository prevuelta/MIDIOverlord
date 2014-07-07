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

-(id)initWithFrame:(NSPoint)size :(int)min :(int)max{
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.x, size.y)];
    
    if(!self) return nil;
    
    _size = size;
    _min = min;
    _max = max;
    _range = max - min;
    
    [self setActive: NO];
    
    _value = [NSNumber numberWithInt: _min];
    
    _marker = [_value intValue];
                
    _textVal = [[uiText alloc] initWithString: [NSString stringWithFormat:@"%03d", [_value intValue]]];
    [_textVal setOrigin:NSMakePoint(RACK_WIDTH - 36 - SCROLLER_WIDTH, 0)];
    [_textVal setDrawBg: NO];
    [_textVal setTextColor:[NSColor whiteColor]];
    [self addSubview: _textVal];
    
//    _label = [[uiText alloc] initWithString: @"" andMaxLength: 4 andLabelLength: 0];
//    [_label setOrigin:NSMakePoint(0, 0)];
//    
//    [_label setDrawBg: NO];
//    
//    [self addSubview: _label];
    
    NSTrackingAreaOptions mouseEnterExitOptions = NSTrackingActiveInActiveApp;
    mouseEnterExitOptions |= NSTrackingMouseEnteredAndExited;
    

//    _trackRect = [[NSTrackingArea alloc] initWithRect: NSMakeRect(-12, 0, 24, size.y) options:mouseEnterExitOptions owner:self userInfo: nil];
    
//    [self addTrackingArea: trackRect ];
    
    return self;
    
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* markerPath = [NSBezierPath new];
    
    [[global sharedGlobalData].darkestGrey set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.size.x, self.size.y)];
    [bgPath closePath];
    [bgPath fill];
    
    [[global sharedGlobalData].markerColor set];
    
    [markerPath appendBezierPathWithRect:NSMakeRect(0, 0, self.marker, self.size.y)];
    [markerPath closePath];
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
//    [_trackRect setRect = NSMakeRect(_marker-12, 0, 24, _size.y);/
//    _trackRect.rect =
}

-(void)updateMarker {
    float percent = [_value floatValue] / (float)self.range;
    int newValue = floor(_size.x * percent);
    [self setMarker: newValue];
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

     float percent = location.x / _size.x;
     int newValue =  percent < 0 ? _min : percent > 1 ? _max : floor(_range * percent);
    
     [self setValue: [NSNumber numberWithInt: newValue]];

     [self setNeedsDisplay:YES];
     
 }


@end

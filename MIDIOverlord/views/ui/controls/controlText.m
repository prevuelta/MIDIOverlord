//
//  controlText.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlText.h"

@implementation controlText

int baseY;

@synthesize value = _value;

- (id)initWithLabel: (NSString*)stringLabel {
    
    _value = @0;
    
    _max = 127;
    
    _stringLabel = stringLabel;
    _stringValue = [self labelPlusValue];
    
    _label = [[uiEditText alloc] initWithString: _stringValue];
    
    NSRect frame = NSMakeRect(0, 0, _label.frame.size.width + 26, 16);
    
    self = [super initWithFrame: frame];
    
    if (!self) return nil;

    uiButton *increase = [[uiButton alloc] initWithSize: 12];
    uiButton *decrease = [[uiButton alloc] initWithSize: 12];
    
    [increase setOrigin:NSMakePoint(_label.frame.size.width, 2)];
    [decrease setOrigin:NSMakePoint(_label.frame.size.width + 14, 2)];
    
    [self addSubview: increase];
    [self addSubview: decrease];
    
    [self addSubview: _label];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    
    [[global sharedGlobalData].markerColor setStroke];
    
    NSRectFill(dirtyRect);
    
	[super drawRect:dirtyRect];
	
    [[global sharedGlobalData].activeColor setStroke];

}

-(NSNumber*)value {
    return _value;
}

-(NSString*)labelPlusValue {
   return  [NSString stringWithFormat:@"%@%03d", _stringLabel, [_value intValue]];
}


-(void)setValue: (NSNumber*)value {
    if([value intValue] >= 0 && [value intValue] <= _max) {
        _value = value;
         NSLog(@"%@", _value);
        [self.label setStringValue: [self labelPlusValue]];
        [self setNeedsDisplay:YES];
    }
}

//-(void)mouseDown:(NSEvent *)e {
//    NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
//    baseY = location.y;
//}
//
//- (void)mouseDragged:(NSEvent*)e {
//        NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
//        int newValue = [_value intValue] + (location.y - baseY);
//        [self setValue: [NSNumber numberWithInt:newValue]];
//        baseY = location.y;
//}

-(void)mouseUp:(NSEvent *)e {

}


@end

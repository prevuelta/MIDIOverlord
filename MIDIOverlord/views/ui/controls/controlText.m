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

- (id)initWithString: (NSString*)stringValue {
    
    _stringValue = stringValue;
    _label = [[uiText alloc] initWithString: stringValue];
    
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

//        NSRectStroke(dirtyRect);
    
//        NSRectStroke(1);

//    [super drawRect:NSMakeRect(0, 0, 20, 20)];

    // Drawing code here.
}

-(NSNumber*)value {
    return _value;
}


-(void)setValue: (NSNumber*)value {
    if([value intValue] >= 0 && [value intValue] <= _max) {
        _value = value;
        [self.label setStringValue: [NSString stringWithFormat:@"CC%@", value]];
        [self setNeedsDisplay:YES];
    }
}

-(void)mouseDown:(NSEvent *)e {
    NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
    baseY = location.y;
}

- (void)mouseDragged:(NSEvent*)e {
        NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
//        NSLog(@"%@", [NSNumber numberWithInt: location.y ]);
//        int newValue = location.y > baseY ? _value + 1 : _value - 1;
        int newValue = [_value intValue] + (location.y - baseY);
        NSLog(@"%@", _value);
        [self setValue: [NSNumber numberWithInt:newValue]];
        baseY = location.y;
}

-(void)mouseUp:(NSEvent *)e {

}


@end

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

- (id)initWithLabel: (NSString*)label andValue: (NSNumber*) value {
    
    _value = @0;
    
    _max = 127;
    
    _label = label;
    
    _labelTextField = [[uiTextField alloc] initWithString: _label];
    
    [self addSubview: _labelTextField];

    _valueNumberField = [[uiEditableNumberField alloc] initWithValue: value andLength: 3];

    [_valueNumberField setOrigin: NSMakePoint(_labelTextField.frameWidth, 0)];
    
    [self addSubview:_valueNumberField];

    NSRect frame = NSMakeRect(0, 0, _labelTextField.frameWidth + _valueNumberField.frameWidth, 16);
    self = [super initWithFrame: frame];
    
    if (!self) return nil;

    // [self bind:@"value" toObject:_valueNumberField withKeyPath:@"value" options:nil];

    // uiButton *increase = [[uiButton alloc] initWithSize: 12];
    // uiButton *decrease = [[uiButton alloc] initWithSize: 12];
    
    // [increase setOrigin:NSMakePoint(_label.frame.size.width, 2)];
    // [decrease setOrigin:NSMakePoint(_label.frame.size.width + 14, 2)];
    
    // [self addSubview: increase];
    // [self addSubview: decrease];
    
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

-(void)setValue: (NSNumber*)value {
    if([value intValue] >= 0 && [value intValue] <= _max) {
        _value = value;
         NSLog(@"Value: %@", _value);
//        [self.label setStringValue: [self labelPlusValue]];
        [self setNeedsDisplay:YES];
    }
}

//-(void)deselect:(NSNotification*)notification {
//    [super deselect:notification];
//    NSLog(@"Int value: %@, %@", self.label.stringValue, [NSNumber numberWithInt:[self.label.stringValue intValue] ]);
//    [self setValue: [NSNumber numberWithInt: [self.stringValue intValue]]];
//}

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

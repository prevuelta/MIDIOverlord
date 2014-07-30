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

//@synthesize value = _value;

- (id)initWithLabel: (NSString*)label andValue: (NSNumber*) value {
    
    _value = value;
    
    _max = 127;
    _min = 0;
    
    _label = label;
    
    _valueNumberField = [[uiEditableNumberField alloc] initWithValue: value andLength: 3];
    
    [_valueNumberField bind:@"max" toObject:self withKeyPath:@"max" options:nil];
    [_valueNumberField bind:@"min" toObject:self withKeyPath:@"min" options:nil];
    
    int width = _valueNumberField.frameWidth;
    
    if(![_label isEqualTo:@""]) {
        NSLog(@"Nolabel: %@", _label);
        _labelTextField = [[uiTextField alloc] initWithString: _label];
        width += _labelTextField.frameWidth;
    }

    [_valueNumberField setOrigin: NSMakePoint(_labelTextField.frameWidth, 0)];

    NSRect frame = NSMakeRect(0, 0, width, 16);
    self = [super initWithFrame: frame];
    
    if (!self) return nil;

    if(![_label isEqualTo:@""]) {
        [self addSubview: _labelTextField];
    }
        
    [self addSubview:_valueNumberField];
    
    [self bind:@"value" toObject:_valueNumberField withKeyPath:@"value" options:nil];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    
    [[global sharedGlobalData].markerColor setStroke];
    
    NSRectFill(dirtyRect);
    
	[super drawRect:dirtyRect];
	
    [[global sharedGlobalData].activeColor setStroke];

}

//-(NSNumber*)value {
//    return _value;
//}
//
//-(void)setValue: (NSNumber*)value {
//    if([value intValue] >= 0 && [value intValue] <= _max) {
//        _value = value;
//         NSLog(@"Value: %@", _value);
////        [self.label setStringValue: [self labelPlusValue]];
//        [self setNeedsDisplay:YES];
//    }
//}

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


@end

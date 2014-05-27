//
//  controlText.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlText.h"

@implementation controlText

@synthesize value = _value;

static NSPoint gridSystem[25];

int baseY;

-(id)initWithFrame:(int)value andLabel:(NSString*)label andMaxVal:(int)max {
    
    _gridCellSizeX = 1;
    _gridCellSizeY = 2;
    _gridPad = 1;
    _gridPad2 = _gridPad * 2;
    _gridCols = 5;
    _gridRows = 5;
    _label = label;
    _value = value;
    _max = max;
    _valueCount = _value < 0 ? 0 : 3;
//    NSLog(@"value count: %@", [NSNumber numberWithInt: _valueCount]);
    _charCount = (int)[_label length];
    _charSizeX = (_gridCellSizeX * _gridCols ) + _gridPad2;
    _charSizeY = (_gridCellSizeY * _gridRows ) + _gridPad2;
    
    _editable = NO;
    
    [self setDefaults];
    
//    NSLog(@"Char count: %@", [NSNumber numberWithInt:_charCount]);
    
    int width = _charSizeX * (_valueCount + _charCount);
    
    self = [super initWithFrame: NSMakeRect(0, 0, width, _charSizeY )];
    
    if(!self) return nil;

    // NSPoint gridSystem[_gridRows * _gridCols];
    
    [self setupGridSystem];
    
    _numbers = @[
       @[@0, @20, @24, @4, @0, @24], // 0
       @[@20, @22, @2, @4, @0], // 1
       @[@20, @24, @14, @10, @0, @4], // 2
       @[@20, @23, @13, @10, @14, @4, @0], // 3
       @[@20, @10, @14, @19, @4], // 4
       @[@24, @20, @10, @14, @4, @0], // 5
       @[@24, @20, @0, @4, @14, @10], // 6
       @[@20, @24, @4], // 7
       @[@11, @21, @23, @13, @10, @0, @4, @14, @13], // 8
       @[@4, @24, @20, @10, @14], // 9
    ];
    
    _letters  = @{
       @"A" : @[@0, @20, @24, @14, @10, @14, @4],
       @"B" : @[@24, @20, @0, @4],
       @"C" : @[@24, @20, @0, @4],
       @"D" : @[@20, @22, @14, @2, @0, @20],
       @"E" : @[@24, @20, @10, @12, @10, @0, @4],
       @"H" : @[@20, @0, @10, @14, @24, @4],
       @"I" : @[@20, @24, @22, @2, @0, @4],
       @"J" : @[@20, @24, @22, @2, @0, @4],
       @"K" : @[@20, @0, @10, @12, @4, @12, @24],
       @"L" : @[@20, @0, @4],
       @"M" : @[@0, @20, @22, @12, @22, @24, @4],
       @"N" : @[@0, @20, @4, @24],
       @"O" : @[@0, @20, @24, @4, @0],
       @"P" : @[@0, @20, @24, @14, @10],
       @"R" : @[@14, @24, @20, @0, @10, @13, @3],
       @"T" : @[@20, @24, @22, @2],
       @"U" : @[@20, @0, @4, @24],
       @"V" : @[@20, @10, @2, @14, @24],
       @"W" : @[@20, @10, @2, @14, @24],
       @"X" : @[@20, @10, @2, @14, @24],
       @"Y" : @[@20, @10, @7, @2, @7, @14, @24],
       @"Z" : @[@20, @10, @2, @14, @24],
       @"0" : @[@0, @20, @24, @4, @0], // 0
       @"1" : @[@20, @22, @2, @4, @0], // 1
       @"." : @[@1, @6, @7, @2]
    };

    
    // [self setFont: [NSFont fontWithName: @"Arial" size: 10]];
    
    return self;
}

-(void)setupGridSystem {
    
    for(int i = 0; i < _gridRows; i++) {
        for(int j = 0; j < _gridCols; j++) {
            float x = (j * _gridCellSizeX) + 0.5 + _gridPad;
            float y = (i * _gridCellSizeY) + 0.5 + _gridPad;
            NSPoint point =  NSMakePoint((CGFloat)x, (CGFloat)y);
            gridSystem[(i*_gridCols)+j] = point;
        }
    }
}

-(void)drawRect:(NSRect)dirtyRect{
    
//   [self.defaultColor setFill];
//    NSRectFill(dirtyRect);
//   [super drawRect:dirtyRect];

    // Drawing code here.
    // Draw letters
    NSBezierPath* letterPath = [NSBezierPath new];
    NSBezierPath* numberPath = [NSBezierPath new];
    
    [letterPath setLineWidth: 1];
    [numberPath setLineWidth: 1];
    

    int charOffset = 0;//_charSizeX * ((_charCount * _valueCount)-1);
    
    for(int c = 0; c < _charCount; c++) {
        NSString *key = [NSString stringWithFormat: @"%c", [_label characterAtIndex:c]];
        NSArray *letterArr = [_letters objectForKey: key];
//        NSLog(@"Letter array: %@", letterArr);
        for(int l = 0; l < [letterArr count]; l++) {
            
            NSNumber *index = letterArr[l];
            NSPoint point = gridSystem[[index integerValue]];
            point.x += charOffset;
            
            if(l == 0) {
                [letterPath moveToPoint: point];
            } else {
                [letterPath lineToPoint: point];
            }
        }
        
        charOffset += _charSizeX;
    }
    
    [self.markerColor set];
    [letterPath stroke];
    
    for(int i = _valueCount-1 ; i >= 0; i--) {
        
        int trimmedLower = _value / (pow(10, i)); // trim the lower half of the input
            
        int number = trimmedLower % 10; // trim the upper half of the input
        
        for(int j = 0; j < [_numbers[number] count]; j++) {
            
            NSNumber *index = _numbers[number][j];
            
            NSPoint point = gridSystem[[index integerValue]];
            
            point.x += charOffset;
            
            if(j == 0) {
                [numberPath moveToPoint: point];
            } else {
                [numberPath lineToPoint: point];
            }
        }

        charOffset += _charSizeX;
        
    }

    [self.activeColor set];

    [numberPath stroke];
}

-(int)value {
    return _value;
}

-(void)setValue: (int)value {
    if(value >= 0 && value <= _max) {
        _value = value;
        [self setNeedsDisplay:YES];
    }
}

-(void)mouseDown:(NSEvent *)e {
    if(self.editable) {
        NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
        baseY = location.y;
        self.active = true;
    }
}

- (void)mouseDragged:(NSEvent*)e {
    if(self.active){
        NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
        NSLog(@"%@", [NSNumber numberWithInt: location.y ]);
//        int newValue = location.y > baseY ? _value + 1 : _value - 1;/
        int newValue = _value + (location.y - baseY);
        NSLog(@"%@", [NSNumber numberWithInt:_value]);
        [self setValue: newValue];
        baseY = location.y;
    }
}

-(void)mouseUp:(NSEvent *)e {
    if(self.editable) {
        self.active = false;
    }
}



@end

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

NSImage * img;

-(id)initWithString:(NSString*)stringValue {
    return [self initWithString:stringValue andMaxLength:[stringValue length] andLabelLength:0];
}

-(id)initWithString:(NSString*)stringValue andMaxLength:(int)maxLength andLabelLength:(int)labelLength {
    
    _gridCellSizeX = 1;
    _gridCellSizeY = 1;
    _letterSpacing = 2;
    _padding = 2;
    _gridCols = 6;
    _gridRows = 9;
    
    _stringValue = stringValue;
    _maxLength = maxLength;

    _charCount = (int)[stringValue length];
    
    _charSizeX = (_gridCellSizeX * (_gridCols-1)) + _letterSpacing;
    _charSizeY = (_gridCellSizeY * (_gridRows-1)) + (_padding * 2);
    
    _editable = NO;
    
    [self setDefaults];
    
    int width = (_charSizeX * _charCount) + (_padding * 2);
    
    self = [super initWithFrame: NSMakeRect(0, 0, width, _charSizeY )];
    
    if(!self) return nil;

    [self setupGridSystem];
    

    _glyphs  = @{
       @"A" : @[@0, @56, @61, @5, @4, @32, @31, @38, @40, @54, @50, @36, @38, @31, @29, @1],
       @"B" : @[@24, @20, @0, @4],
       @"C" : @[@24, @20, @0, @4],
       @"D" : @[@0, @48, @51, @45, @46, @40, @41, @17, @16, @10, @9, @3, @1, @7, @9, @15, @16, @40, @39, @45, @43, @1],
       @"E" : @[@24, @20, @10, @12, @10, @0, @4],
       @"H" : @[@20, @0, @10, @14, @24, @4],
       @"I" : @[@0, @5, @11, @9, @45, @47, @53, @48, @42, @44, @8, @6],
       @"J" : @[@20, @24, @22, @2, @0, @4],
       @"K" : @[@20, @0, @10, @12, @4, @12, @24],
       @"L" : @[@20, @0, @4],
       @"M" : @[@0, @48, @49, @43, @44, @38, @39, @45, @46, @52, @53, @5, @4, @46, @40, @39, @33, @32, @38, @37, @1],
       @"N" : @[@0, @20, @4, @24],
       @"O" : @[@0, @48, @53, @5, @1, @7, @10, @46, @43, @1],
       @"P" : @[@0, @20, @24, @14, @10],
       @"R" : @[@14, @24, @20, @0, @10, @13, @3, @4],
       @"T" : @[@20, @24, @22, @2],
       @"U" : @[@20, @0, @4, @24],
       @"V" : @[@20, @10, @2, @14, @24],
       @"W" : @[@20, @10, @2, @14, @24],
       @"X" : @[@20, @10, @2, @14, @24],
       @"Y" : @[@20, @10, @7, @2, @7, @14, @24],
       @"Z" : @[@20, @10, @2, @14, @24],
       @"." : @[@1, @6, @7, @2],
       @0   : @[@0, @20, @24, @4, @0], // 0
       @1   : @[@20, @22, @2, @4, @0], // 1
       @2   : @[@20, @24, @14, @10, @0, @4], // 2
       @3   : @[@20, @23, @13, @10, @14, @4, @0], // 3
       @4   : @[@20, @10, @14, @19, @4], // 4
       @5   : @[@24, @20, @10, @14, @4, @0], // 5
       @6   : @[@24, @20, @0, @4, @14, @10], // 6
       @7   : @[@20, @24, @4], // 7
       @8   : @[@11, @21, @23, @13, @10, @0, @4, @14, @13], // 8
       @9   : @[@4, @24, @20, @10, @14] // 9
    };

    
    // [self setFont: [NSFont fontWithName: @"Arial" size: 10]];
    
    return self;
}

-(void)setupGridSystem {
    
    for(int i = 0; i < _gridRows; i++) {
        for(int j = 0; j < _gridCols; j++) {
            float x = (j * _gridCellSizeX) + _padding;
            float y = (i * _gridCellSizeY) + _padding;
            NSPoint point =  NSMakePoint((CGFloat)x, (CGFloat)y);
            gridSystem[(i*_gridCols)+j] = point;
        }
    }
}

-(void)drawRect:(NSRect)dirtyRect{

   [self.defaultColor setFill];
    NSRectFill(dirtyRect);
   [super drawRect:dirtyRect];

    // Draw Glyphs
    NSBezierPath* glyphPath = [NSBezierPath new];
    
    int charOffset = 0;//_charSizeX * ((_charCount * _valueCount)-1);
    
    for(int i = 0; i < _charCount; i++) {
        NSString *key = [NSString stringWithFormat: @"%c", [_stringValue characterAtIndex:i]];
        NSArray *glyphArr = _glyphs[key];
        for(int j = 0; j < [glyphArr count]; j++) {
            NSPoint orginalPoint;
            NSNumber *index = glyphArr[j];
            NSPoint point = gridSystem[[index integerValue]];
            point.x += charOffset;
            if(j == 0) {
                [glyphPath moveToPoint: point];
                orginalPoint = point;
            } else {
                [glyphPath lineToPoint: point];
                if(j == [glyphArr count]) {
                    [glyphPath lineToPoint: orginalPoint];
                }
            }
        }

        charOffset += _charSizeX;
    }
    
    [self.markerColor set];
    [glyphPath fill];
    
}

//-(int)value {
//    return _value;
//}
//
//-(void)setValue: (int)value {
//    if(value >= 0 && value <= _max) {
//        _value = value;
//        [self setNeedsDisplay:YES];
//    }
//}

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

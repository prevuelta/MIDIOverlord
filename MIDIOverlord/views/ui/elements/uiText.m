//
//  controlText.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiText.h"

@implementation uiText

@synthesize stringValue = _stringValue;

static NSPoint gridSystem[25];

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
    
    _labelLength = labelLength;

    _charCount = (int)[stringValue length];
    
    _charSizeX = (_gridCellSizeX * (_gridCols-1)) + _letterSpacing;
    _charSizeY = (_gridCellSizeY * (_gridRows-1)) + (_padding * 2);
    
    _editable = NO;

    int width = (_charSizeX * MIN(_charCount, _maxLength)) + ((_padding * 2) - _letterSpacing);
    
    self = [super initWithFrame: NSMakeRect(0, 0, width, _charSizeY )];
    
    if(!self) return nil;

    [self setupGridSystem];
    

    _glyphs  = @{
       // Uppercase
       @"A" : @[@5, @53, @48, @0, @1, @25, @28, @34, @31, @43, @46, @4],
       @"B" : @[@35, @53, @48, @0, @5, @29, @28, @10, @7, @25, @28, @34, @31, @43, @46, @34],
       @"C" : @[@41, @40, @46, @43, @7, @10, @16, @17, @5, @0, @48, @53, @41],
       @"D" : @[@0, @48, @51, @45, @46, @40, @41, @17, @16, @10, @9, @3, @1, @7, @9, @15, @16, @40, @39, @45, @43, @1],
       @"E" : @[@53, @48, @0, @5, @11, @7, @25, @28, @34, @31, @43, @47],
       @"F" : @[],
       @"G" : @[],
       @"H" : @[@20, @0, @10, @14, @24, @4],
       @"I" : @[@0, @5, @11, @9, @45, @47, @53, @48, @42, @44, @8, @6],
       @"J" : @[@20, @24, @22, @2, @0, @4],
       @"K" : @[@52, @34, @31, @49, @48, @0, @1, @25, @28, @4, @5, @29, @28, @34, @35, @53],
       @"L" : @[@20, @0, @4],
       @"M" : @[@0, @48, @49, @43, @44, @38, @39, @45, @46, @52, @53, @5, @4, @46, @40, @39, @33, @32, @38, @37, @1],
       @"N" : @[@0, @20, @4, @24],
       @"O" : @[@0, @48, @53, @5, @1, @7, @10, @46, @43, @1],
       @"P" : @[@0, @48, @53, @29, @25, @31, @34, @46, @43, @1],
       @"Q" : @[],
       @"R" : @[@0, @48, @53, @29, @28, @22, @23, @5, @4, @22, @21, @27, @25, @31, @34, @46, @43, @1],
       @"S" : @[],
       @"T" : @[@20, @24, @22, @2],
       @"U" : @[@20, @0, @4, @24],
       @"V" : @[@20, @10, @2, @14, @24],
       @"W" : @[@20, @10, @2, @14, @24],
       @"X" : @[@20, @10, @2, @14, @24],
       @"Y" : @[@20, @10, @7, @2, @7, @14, @24],
       @"Z" : @[@20, @10, @2, @14, @24],
       // Lowercase
       @"e" : @[@11, @7, @13, @17, @35, @30, @18, @19, @25, @28, @22, @18, @0, @5],
       @"s" : @[@35, @30, @12, @16, @10, @6, @0, @5, @23, @19, @25, @29],
       // Puncuation
       @"." : @[@1, @7, @8, @2],
       @"#" : @[@1, @7, @6, @12, @13, @25, @24, @30, @31, @37, @38, @32, @33, @39, @40, @34, @35, @29, @28, @16, @17, @11, @10, @4, @3, @9, @8, @14, @15, @27, @26, @2],
       // Numerals
       @"0" : @[@48, @0, @5, @53, @49, @43, @46, @10, @7, @49],
       @"1" : @[@0, @5, @11, @9, @51, @48, @42, @44, @8, @6],
       @"2" : @[@48, @53, @29, @25, @7, @11, @5, @0, @30, @34, @46, @42],
       @"3" : @[@48, @42, @46, @34, @31, @25, @28, @10, @6, @0, @5, @53],
       @"4" : @[@48, @18, @22, @4, @5, @53, @52, @28, @25, @49],
       @"5" : @[@53, @48, @24, @28, @10, @6, @0, @5, @35, @31, @43, @47],
       @"6" : @[@53, @48, @0, @5, @29, @25, @19, @22, @10, @7, @43, @47],
       @"7" : @[@48, @53, @29, @28, @22, @21, @15, @14, @2, @1, @19, @20, @26, @27, @33, @34, @46, @42],
       @"8" : @[@53, @48, @0, @5, @29, @28, @10, @7, @25, @29, @47, @46, @34, @31, @43, @47],
       @"9" : @[@5, @53, @48, @24, @28, @34, @31, @43, @46, @4]
    };

    
    // [self setFont: [NSFont fontWithName: @"Arial" size: 10]];
    
    return self;
}

-(void)setStringValue:(NSString *)stringValue {
    _stringValue = stringValue;
    _charCount = [stringValue length];
//    [self setNeedsDisplay:YES];
}

-(NSString*)stringValue {
    return _stringValue;
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
    
    for(int i = 0; i < _charCount && i < _maxLength; i++) {
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
        
        if(i < _labelLength) {
            
        } else {
            
        }
    }
    
    [self.markerColor set];
    [glyphPath fill];
    
}


@end

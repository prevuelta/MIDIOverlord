//
//  controlText.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiTextField.h"

@implementation uiTextField

@synthesize stringValue = _stringValue;

static NSPoint gridSystem[54];

//-(id)initWithString:(NSString*)stringValue andSize:(NSArray*)size {
//    return [self initWithString:stringValue andMaxLength:(int)[stringValue length] andLabelLength:0];
//
//}

-(id)initWithString:(NSString*)stringValue {
    return [self initWithString:stringValue andMaxLength:(int)[stringValue length]];
}

-(id)initWithString:(NSString*)stringValue andMaxLength:(int)maxLength {
    
    _gridCellSizeX = 1;
    _gridCellSizeY = 1;
    _letterSpacing = 2;
    _padding = 4;
    _gridCols = 6;
    _gridRows = 9;
    _maxLength = maxLength;
    
    _drawBg = YES;
    
    _charSizeX = (_gridCellSizeX * (_gridCols-1)) + _letterSpacing;
    _charSizeY = (_gridCellSizeY * (_gridRows-1)) + (_padding * 2);
    
    _textColor = [global sharedGlobalData].colors[@"brown"];
    
    _bgColor = [global sharedGlobalData].black;

    int width = (_charSizeX * _maxLength) + ((_padding * 2) - _letterSpacing);
    
    self = [super initWithFrame: NSMakeRect(0, 0, width, _charSizeY )];
    
    if(!self) return nil;

    [self setStringValue: stringValue];
    
    _glyphs  = @{
       // Uppercase
        @"A" : @[@5, @53, @48, @0, @1, @25, @28, @34, @31, @43, @46, @4],
        @"B" : @[@35, @53, @48, @0, @5, @29, @28, @10, @7, @25, @28, @34, @31, @43, @46, @34],
        @"C" : @[@41, @40, @46, @43, @7, @10, @16, @17, @5, @0, @48, @53, @41],
        @"D" : @[@0, @48, @51, @45, @46, @40, @41, @17, @16, @10, @9, @3, @1, @7, @9, @15, @16, @40, @39, @45, @43, @1],
        @"E" : @[@53, @48, @0, @5, @11, @7, @25, @28, @34, @31, @43, @47],
        @"F" : @[@0, @1, @25, @28, @34, @31, @43, @47, @53, @48],
        @"G" : @[@41, @53, @48, @0, @5, @29, @26, @20, @22, @10, @7, @43, @46, @40],
        @"H" : @[@48, @0, @1, @25, @28, @4, @5, @53, @52, @34, @31, @49],
        @"I" : @[@0, @5, @11, @9, @45, @47, @53, @48, @42, @44, @8, @6],
        @"J" : @[@49, @43, @46, @10, @6, @0, @4, @10, @11, @53],
        @"K" : @[@49, @25, @26, @32, @33, @39, @40, @46, @47, @41, @40, @34, @33, @27, @26, @20, @21, @15, @16, @10, @11, @5, @4, @10, @9, @15, @14, @20, @19, @1, @0, @48],
        @"L" : @[@48, @0, @5, @11, @7, @49],
        @"M" : @[@0, @48, @49, @43, @44, @38, @39, @45, @46, @52, @53, @5, @4, @46, @40, @39, @33, @32, @38, @37, @1],
        @"N" : @[@0, @48, @49, @43, @44, @38, @39, @33, @34, @52, @53, @5, @4, @28, @27, @33, @32, @38, @37, @1],
        @"O" : @[@0, @48, @53, @5, @1, @7, @10, @46, @43, @1],
        @"P" : @[@0, @48, @53, @29, @25, @31, @34, @46, @43, @1],
        @"Q" : @[@48, @0, @4, @16, @15, @21, @20, @14, @15, @9, @7, @43, @46, @4, @5, @53],
        @"R" : @[@0, @48, @53, @29, @28, @22, @23, @5, @4, @22, @21, @27, @25, @31, @34, @46, @43, @1],
        @"S" : @[@53, @48, @24, @28, @10, @6, @0, @5, @35, @31, @43, @47],
        @"T" : @[@2, @44, @42, @48, @53, @47, @45, @3],
        @"U" : @[@48, @0, @5, @53, @52, @10, @7, @49],
        @"V" : @[@2, @8, @7, @13, @12, @48, @49, @13, @14, @8, @9, @15, @16, @52, @53, @17, @16, @10, @9, @3],
        @"W" : @[@48, @0, @1, @7, @8, @14, @15, @9, @10, @4, @5, @53, @52, @16, @15, @21, @20, @14, @13, @49],
        @"X" : @[@0, @12, @13, @19, @20, @26, @25, @31, @30, @48, @49, @31, @32, @26, @27, @33, @34, @52, @53, @35, @34, @28, @27, @21, @22, @16, @17, @5, @4, @16, @15, @21, @20, @14, @13, @1],
        @"Y" : @[@48, @18, @20, @2, @3, @21, @23, @53, @52, @28, @25, @49],
        @"Z" : @[@48, @53, @47, @46, @34, @33, @21, @20, @8, @11, @5, @0, @6, @7, @19, @20, @32, @33, @45, @42],
       // Lowercase

        @"a" : @[@30, @35, @5, @0, @18, @22, @16, @13, @7, @10, @28, @24],
        @"b" : @[@48, @0, @5, @35, @31, @25, @28, @10, @7, @49],
        @"c" : @[@35, @30, @0, @5, @11, @7, @25, @29],
        @"d" : @[@34, @30, @0, @5, @53, @52, @10, @7, @25, @28],
        @"e" : @[@11, @7, @13, @17, @35, @30, @18, @19, @25, @28, @22, @18, @0, @5],
        @"f" : @[@2, @26, @24, @30, @32, @50, @53, @47, @45, @33, @35, @29, @27, @3],
        @"g" : @[@35, @30, @12, @16, @10, @6, @0, @5, @29, @28, @22, @19, @25, @29],
        @"h" : @[@48, @0, @1, @25, @28, @4, @5, @35, @31, @49],
        @"i" : @[@1, @4, @10, @9, @33, @31, @25, @26, @8, @7, @44, @45, @39, @38],
        @"j" : @[@6, @10, @28, @29, @5, @0, @6, @40, @34, @35, @41, @40],
        @"k" : @[@48, @0, @1, @13, @16, @4, @5, @17, @16, @22, @23, @35, @31, @25, @28, @22, @19, @49],
        @"l" : @[@50, @2, @4, @10, @9, @51],
        @"m" : @[@0, @30, @35, @5, @4, @28, @27, @15, @14, @26, @25, @1],
        @"n" : @[@0, @30, @35, @5, @4, @28, @25, @1],
        @"o" : @[@35, @30, @0, @5, @29, @28, @10, @7, @25, @29],
        @"p" : @[@0, @30, @35, @17, @13, @19, @22, @28, @25, @1],
        @"q" : @[@30, @12, @16, @22, @19, @25, @28, @4, @5, @35],
        @"r" : @[@0, @30, @35, @29, @25, @1],
        @"s" : @[@35, @30, @12, @16, @10, @6, @0, @5, @23, @19, @25, @29],
        @"t" : @[@50, @32, @30, @24, @26, @2, @5, @11, @9, @27, @29, @35, @33, @51],
        @"u" : @[@30, @0, @5, @35, @34, @10, @7, @31],
        @"v" : @[@30, @12, @13, @7, @8, @2, @3, @9, @10, @16, @17, @35, @34, @16, @15, @9, @8, @14, @13, @31],
        @"w" : @[@30, @0, @5, @35, @34, @10, @9, @21, @20, @8, @7, @31],
        @"x" : @[@30, @31, @25, @26, @20, @21, @27, @28, @34, @35, @29, @28, @22, @21, @15, @16, @10, @11, @5, @4, @10, @9, @15, @14, @8, @7, @1, @0, @6, @7, @13, @14, @20, @19, @25, @24],
        @"y" : @[@30, @12, @16, @10, @6, @0, @5, @35, @34, @22, @19, @31],
        @"z" : @[@30, @35, @29, @28, @22, @21, @15, @14, @8, @11, @5, @0, @6, @7, @13, @14, @20, @21, @27, @24],

        // Puncuation
        @"_" : @[@6, @11, @5, @0],
        @"!" : @[@51, @21, @20, @50, @51, @8, @9, @3, @2, @8],
        @"@" : @[],
        @"#" : @[@1, @7, @6, @12, @13, @25, @24, @30, @31, @37, @38, @32, @33, @39, @40, @34, @35, @29, @28, @16, @17, @11, @10, @4, @3, @9, @8, @14, @15, @27, @26, @2],
        @"$" : @[@47, @45, @51, @50, @44, @42, @18, @22, @10, @9, @21, @20, @8, @6, @0, @5, @29, @25, @37, @38, @26, @27, @39, @41],
        @"%" : @[],
        @"^" : @[@50, @44, @43, @37, @38, @44, @45, @39, @40, @46, @45, @51],
        @"&" : @[@53, @41, @40, @28, @27, @15, @14, @13, @7, @10, @22, @23, @5, @0, @18, @19, @25, @24, @48, @52, @43, @31, @25, @29],
        @"*" : @[@36, @37, @31, @32, @44, @45, @33, @34, @40, @41, @35, @34, @28, @29, @23, @22, @28, @27, @15, @14, @26, @25, @19, @18, @24, @25, @31, @30],
        @"(" : @[],
        @")" : @[],
        @"-" : @[@29, @24, @18, @23],
        @"=" : @[@17, @12, @18, @23, @17, @29, @24, @30, @35, @29],
        @"+" : @[@38, @26, @24, @18, @20, @8, @9, @21, @23, @29, @27, @39],
        @"[" : @[@52, @49, @1, @4, @10, @8, @44, @46],
        @"]" : @[@49, @52, @4, @1, @7, @9, @45, @43],
        @"{" : @[@51, @50, @44, @43, @31, @30, @24, @25, @7, @8, @2, @3, @9, @8, @26, @25, @31, @32, @44, @45],
        @"}" : @[],
//        @"|" : @[@50, @2, @3, @51],
        @"," : @[@13, @7, @8, @2, @3, @15],
        @"." : @[@1, @7, @8, @2],
        @"/" : @[@0, @12, @13, @25, @26, @38, @39, @51, @52, @40, @39, @27, @26, @14, @13, @1],
        @"<" : @[],
        @">" : @[],
        @"?" : @[@8, @2, @3, @9, @8, @20, @21, @27, @28, @34, @35, @53, @48, @42, @46, @34, @33, @27, @26, @20],
        @":" :  @[@38, @32, @33, @39, @38, @14, @8, @9, @15, @14],
        @"\"" : @[@5, @17, @16, @28, @27, @39, @38, @50, @49, @37, @38, @26, @27, @15, @16, @4],
        @"'" : @[@50, @44, @45, @39, @40, @52, @50],
        @";" : @[@14, @8, @9, @3, @4, @16, @14, @32, @26, @27, @33],

        // Icons
        @"|" : @[@42, @44, @50, @51, @21, @23, @5, @2, @8, @38, @36], // Musical note
        
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

    [self setupGridSystem];
    
    // [self setFont: [NSFont fontWithName: @"Arial" size: 10]];
    
    return self;
}

-(NSString*)stringValue {
    return _stringValue;
}

-(void)setStringValue:(NSString *)stringValue {

    NSRange range = {0, MIN([stringValue length], _maxLength)};
    
    _stringValue = [stringValue substringWithRange:range];
    NSLog(@"Set string to: %@", _stringValue);
    
//    [self setCharCount: MIN((int)[_stringValue length], _maxLength)];
    [self setNeedsDisplay: YES];
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

    if(_drawBg) {
        [self.bgColor setFill];
    
        NSRectFill(dirtyRect);
    
        [super drawRect:dirtyRect];
    }

    [_textColor set];
    
    // Draw Glyphs
    NSBezierPath* glyphPath = [NSBezierPath new];
    
    int charOffset = 0;//_charSizeX * ((_charCount * _valueCount)-1);
    
    for(int i = 0; i < [_stringValue length]; i++) {
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
    
    [glyphPath fill];
    
}


@end

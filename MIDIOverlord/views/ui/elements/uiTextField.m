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
    _isInverted = NO;
    
    _drawBg = YES;
    
    _charSizeX = (_gridCellSizeX * (_gridCols-1)) + _letterSpacing;
    _charSizeY = (_gridCellSizeY * (_gridRows-1)) + (_padding * 2);
    
    _textColor = [global sharedGlobalData].colors[@"red"];
    _textColorInverted = [global sharedGlobalData].colors[@"blue"];
    
    _bgColor = [global sharedGlobalData].colors[@"darkBrown"];

    int width = (_charSizeX * _maxLength) + ((_padding * 2) - _letterSpacing);
    
    self = [super initWithFrame: NSMakeRect(0, 0, width, _charSizeY )];
    
    if(!self) return nil;

    [self setStringValue: stringValue];

    [self setupGridSystem];
    
    return self;
}

-(NSString*)stringValue {
    return _stringValue;
}

-(void)setStringValue:(NSString *)stringValue {

    NSRange range = {0, MIN([stringValue length], _maxLength)};
    
    _stringValue = [stringValue substringWithRange:range];
//    NSLog(@"Set string to: %@", _stringValue);
    
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
    
     [_textColor setFill];

    if([self isInverted]) {
        [_textColorInverted setFill];
    }
   
    
    // Draw Glyphs
    NSBezierPath* glyphPath = [NSBezierPath new];
    
    int charOffset = 0;//_charSizeX * ((_charCount * _valueCount)-1);
    
    for(int i = 0; i < [_stringValue length]; i++) {
        NSString *key = [NSString stringWithFormat: @"%c", [_stringValue characterAtIndex:i]];
        NSArray *glyphArr = [global sharedGlobalData].glyphs[key];
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

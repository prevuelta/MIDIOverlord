//
//  controlText.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "uiBase.h"
#import "global.h"

@interface uiTextField : uiBase

@property int gridCellSizeX;
@property int gridCellSizeY;
@property int letterSpacing;
@property int padding;
@property int gridCols;
@property int gridRows;
@property BOOL drawBg;
@property NSString *stringValue;
//@property int charCount;
@property int charSizeX;
@property int charSizeY;
@property int maxLength;
@property NSColor* textColor;
@property NSColor* textColorInverted;
@property NSColor* bgColor;
@property BOOL isInverted;

-(id)initWithString:(NSString*)stringValue;
-(id)initWithString:(NSString*)stringValue andMaxLength:(int)maxLength;
-(void)setupGridSystem;

@end

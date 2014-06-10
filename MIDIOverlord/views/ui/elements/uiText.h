//
//  controlText.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "uiBase.h"

@interface uiText : uiBase

@property NSString *label;
@property int value;

@property int gridCellSizeX;
@property int gridCellSizeY;
@property int letterSpacing;
@property int padding;
@property int gridCols;
@property int gridRows;

@property NSDictionary *glyphs;

@property NSString *stringValue;

@property int charCount;

@property int charSizeX;
@property int charSizeY;

@property int maxLength;

@property BOOL editable;

-(id)initWithString:(NSString*)stringValue;

-(id)initWithString:(NSString*)stringValue andMaxLength:(int)maxLength andLabelLength: (int)labelLength;
-(void)setupGridSystem;

@end

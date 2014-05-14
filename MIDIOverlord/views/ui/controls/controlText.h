//
//  controlText.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "controlBase.h"

@interface controlText : controlBase

@property NSString *label;
@property int value;

@property int gridCellSizeX;
@property int gridCellSizeY;
@property int gridPad;
@property int gridPad2;
@property int gridCols;
@property int gridRows;
@property NSDictionary *letters;
@property NSArray *numbers;

@property int charCount;
@property int valueCount;
@property int charSizeX;
@property int charSizeY;

@property BOOL editable;

-(id)initWithFrame:(int)value andLabel:(NSString*)label;

@end

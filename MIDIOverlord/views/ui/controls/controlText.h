//
//  controlText.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiTextField.h"
#import "uiEditableNumberField.h"
#import "controlBase.h"

@interface controlText : controlBase;

@property NSNumber *value;
@property NSString* label;

@property uiTextField *labelTextField;
@property uiEditableNumberField *valueNumberField;

@property int min;
@property int max;

@property BOOL showNote;

@property NSString *nullString;

-(id)initWithLabel: (NSString*)label andValue:(NSNumber*)value;
-(id)initWithLabel: (NSString*)label andValue: (NSNumber*) value andNullString:(NSString*)nullString;

@end

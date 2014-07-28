//
//  uiEditableTextFieldNumbers.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 8/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiEditableTextField.h"

@interface uiEditableNumberField : uiEditableTextField

@property NSNumber* value;
@property int min;
@property int max;

-(id)initWithValue:(NSNumber*)value andLength:(int)length;
-(NSNumber*)checkRange:(NSNumber*)number;

-(void)setValueFromString;
-(void)setStringFromValue;

-(void)increment:(BOOL)increment;



@end

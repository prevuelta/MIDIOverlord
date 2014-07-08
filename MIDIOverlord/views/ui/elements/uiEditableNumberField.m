//
//  uiEditableTextFieldNumbers.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 8/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiEditableNumberField.h"

@implementation uiEditableNumberField

@synthesize stringValue = _stringValue;

-(id)initWithValue:(NSNumber*)value andLength:(int)length {
    
    _value = value;
    
    self = [super initWithString: [value stringValue] andMaxLength: length];

    self.invalidChars = [global sharedGlobalData].notNumbers;
    
    return self;
}

-(NSString*)stringvalue {
	return _stringValue;
}

// -(void)setStringValue:(NSString*)stringValue {
// 	[self setValue: [NSNumber numberWithInt: [self.stringValue intValue] ]];
// 	_stringValue = stringValue;
// }

-(void)setStringValue:(NSString *)stringValue {
    _stringValue = stringValue;
    [self setCharCount: MIN((int)[self.stringValue length], self.maxLength)];
}


@end

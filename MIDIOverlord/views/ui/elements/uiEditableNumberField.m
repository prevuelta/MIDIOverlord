//
//  uiEditableTextFieldNumbers.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 8/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiEditableNumberField.h"

@implementation uiEditableNumberField

// @synthesize stringValue = _stringValue;

-(id)initWithValue:(NSNumber*)value andLength:(int)length {
    
    _value = value;
    
    self = [super initWithString: [value stringValue] andMaxLength: length];

    _max = 127;
    _min = 0;

    // self.invalidChars = [global sharedGlobalData].notNumbers;
    
    return self;
}

-(void)deselectHook {
	NSNumber *newValue = [self checkRange: [self.savedString intValue]];
	[self setValue: newValue];
	[self setStringValue: [newValue stringValue]];
}

-(NSNumber*)checkRange:(int)intValue {
	return [NSNumber numberWithInt: intValue > _max ? _max : intValue < _min ? _min : intValue];
}

// -(NSString*)stringvalue {
// 	return _stringValue;
// }

// -(void)setStringValue:(NSString*)stringValue {
// 	[self setValue: [NSNumber numberWithInt: [self.stringValue intValue] ]];
// 	_stringValue = stringValue;
// }

// -(void)setStringValue:(NSString *)stringValue {
//     NSLog(@"Setting string... %@", stringValue);
//     _stringValue = stringValue;
//     [self setCharCount: MIN((int)[self.stringValue length], self.maxLength)];
// }


@end

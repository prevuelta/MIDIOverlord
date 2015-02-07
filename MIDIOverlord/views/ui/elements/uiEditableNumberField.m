//
//  uiEditableTextFieldNumbers.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 8/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiEditableNumberField.h"

@implementation uiEditableNumberField

@synthesize value = _value;

-(id)initWithValue:(NSNumber*)value andLength:(int)length {
    return [self initWithValue: value andLength: length andNullString: @"---"];
}

-(id)initWithValue:(NSNumber*)value andLength:(int)length andNullString: (NSString*)nullString {
    
    _value = value;
    
    self.nullString = nullString;
    
    if([value isEqualTo: @-1]) {
        self = [super initWithString: self.nullString andMaxLength: length andNullString: nullString];
    } else {
        self = [super initWithString: [value stringValue] andMaxLength: length andNullString: nullString];
    }
    
    _max = 127;
    _min = 0;
    
    self.invalidChars = [global sharedGlobalData].notNumbers;
    
    return self;
}

-(void)deselectHook {
    if([self.savedString isEqualTo: self.nullString]) {
        [self setValue: @-1];
    } else {
        [self setValueFromString];
        [self setStringFromValue];
    }
}

-(void)keyDown:(NSEvent *)event {
    
    switch([event keyCode]) {
        case 126: // Arrow up
            [self increment:YES];
            return;
        break;
        case 125: // Arrow down
            [self increment:NO];
            return;
        break;
    }
    
    [super keyDown:event];
    
}

-(NSNumber*)value {
    return _value;
}

-(void)setValue:(NSNumber*)value {
    NSNumber* newValue = [self checkRange: value];
    NSLog(@"Number field value setting: %@", value);
    _value = newValue;
    [self setStringFromValue];
}

-(NSNumber*)checkRange:(NSNumber*)number {
    int intValue = [number intValue];
	return [NSNumber numberWithInt: intValue > _max ? _max : intValue < _min ? _min : intValue];
}

-(void)increment:(BOOL)increment {
    [self setValue: @([self.stringValue intValue] + (increment ? 1 : -1))];
    [self setStringFromValue];
}

-(void)setValueFromString {
    [self setValue: [NSNumber numberWithInt: [self.savedString intValue]]];
}

-(void)setStringFromValue {
    [self setStringValue: [_value stringValue]];
}

@end

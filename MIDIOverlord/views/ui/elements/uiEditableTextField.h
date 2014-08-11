//
//  uiEditableTextField.h
//  MIDIOverlord
//
//  Created by Pablo on 14/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiTextField.h"

@interface uiEditableTextField : uiTextField

@property BOOL isEditable;
@property BOOL isEditing;

@property int cursorPosition;

@property NSString *tempString;
@property NSString *savedString;

@property NSCharacterSet* invalidChars;

@property NSColor *editTextColor;

@property NSString *nullString;

//-(void)handleDoubleClick:(NSEvent *)e;
-(void)addCharacter:(NSString*)letter;
-(void)removeCharacter;
-(void)deselectHook;

-(id)initWithString:(NSString*)stringValue andMaxLength:(int)maxLength andNullString:(NSString*)nullString;

@end

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

//-(void)handleDoubleClick:(NSEvent *)e;
-(void)addCharacter:(NSString*)letter;
-(void)removeCharacter;
-(void)deselectHook;

@end

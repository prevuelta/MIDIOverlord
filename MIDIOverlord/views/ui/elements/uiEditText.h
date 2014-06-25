//
//  uiEditText.h
//  MIDIOverlord
//
//  Created by Pablo on 14/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiText.h"

@interface uiEditText : uiText

@property BOOL isEditable;
@property BOOL isEditing;

@property NSString *tempString;

-(void)handleDoubleClick:(NSEvent *)e;
-(void)addCharacter:(NSString*)letter;
-(void)removeCharacter;
@end

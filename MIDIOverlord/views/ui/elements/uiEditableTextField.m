//
//  uiEditableTextField.m
//  MIDIOverlord
//
//  Created by Pablo on 14/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiEditableTextField.h"

@implementation uiEditableTextField

@synthesize stringValue = _stringValue;
@synthesize cursorPosition = _cursorPosition;

BOOL firstKey = true;

-(id)initWithString:(NSString*)stringValue andMaxLength:(int)maxLength{
    return [self initWithString:stringValue andMaxLength:maxLength andNullString: @"+++"];
    
}

-(id)initWithString:(NSString*)stringValue andMaxLength:(int)maxLength andNullString:(NSString*)nullString {
    
    _invalidChars = [global sharedGlobalData].invalidChars;
    
    self = [super initWithString:stringValue andMaxLength:maxLength];
    
    self.savedString = stringValue;
//    self.textColor = [global sharedGlobalData].colors[@"blue"];
    self.editTextColor = [global sharedGlobalData].colors[@"red"];
    
    self.nullString = nullString;
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    if(self.isEditing) {
//        self.textColor = [global sharedGlobalData].colors[@"yellow"];
//        self.bgColor = [global sharedGlobalData].black;
    } else {
//        self.textColor = [global sharedGlobalData].colors[@"brown"];
//        self.bgColor = [global sharedGlobalData].defaultColor;
    }
    
    [super drawRect:dirtyRect];
    
    if(self.isEditing) {
    
        [self.editTextColor setFill];
        
        NSBezierPath *outline = [NSBezierPath new];
        NSBezierPath *cursor = [NSBezierPath new];
        
        int offset1 = (self.charSizeX * self.cursorPosition) + self.padding ;
        int offset2 = (self.charSizeX * (self.cursorPosition+1)) + self.padding - self.letterSpacing;
        
        [cursor moveToPoint: NSMakePoint(offset1, 2)];
        [cursor lineToPoint: NSMakePoint(offset2, 2)];
        [cursor lineToPoint: NSMakePoint(offset2, 3)];
        [cursor lineToPoint: NSMakePoint(offset1, 3)];
        
        [outline moveToPoint:NSZeroPoint];
        [outline lineToPoint:NSMakePoint(self.frame.size.width, 0)];
        [outline lineToPoint:NSMakePoint(self.frame.size.width, self.frame.size.height)];
        [outline lineToPoint:NSMakePoint(0, self.frame.size.height)];
        [outline lineToPoint:NSMakePoint(0, 1)];
        [outline lineToPoint:NSMakePoint(1, 1)];
        [outline lineToPoint:NSMakePoint(1, self.frame.size.height-1)];
        [outline lineToPoint:NSMakePoint(self.frame.size.width-1, self.frame.size.height-1)];
        [outline lineToPoint:NSMakePoint(self.frame.size.width-1, 1)];
        [outline lineToPoint:NSMakePoint(0, 1)];
       
        [outline fill];
        [cursor fill];
    }
}

//- (void)mouseUp:(NSEvent *)event {
//    NSInteger clickCount = [event clickCount];
//    if (2 == clickCount) [self handleDoubleClick:event];
//}


-(int)cursorPosition {
    return _cursorPosition;
}

-(void)setCursorPosition:(int)cursorPosition {
//    NSLog(@"setting %@", [NSNumber numberWithInt: cursorPosition]);
//    NSLog(@"String %@", self.stringValue);
//    NSLog(@"String length %@", [NSNumber numberWithInt: [self.stringValue length]]);
    _cursorPosition = cursorPosition < 0 ? 0 : cursorPosition >= [self.stringValue length] ? (int)[self.stringValue length] : cursorPosition;
//    NSLog(@"setting %@", [NSNumber numberWithInt: _cursorPosition]);
}

-(NSString*)stringValue {
    return [super stringValue];
}

-(void)setStringValue:(NSString *)stringValue {
//    NSLog(@"Setting in editable: %@", stringValue);
    [super setStringValue: stringValue];
}

-(void)mouseDown:(NSEvent *)theEvent {
    [global deselectNotify];

    if([self.stringValue isEqualToString: self.nullString])
        [self setStringValue:@""];

    _tempString = self.stringValue;

    self.cursorPosition = [self.stringValue length] + 1;
    
    [self setIsEditing: YES];
    [self setNeedsDisplay: YES];
    [self.window makeFirstResponder: self];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

-(void)keyDown:(NSEvent *)event {

    switch([event keyCode]) {
        case 51 :
            [self removeCharacter]; // Delete key
            break;
        case 36:
        case 76:
            NSLog(@"Done di edit");
            [self deselect: nil]; // Enter key
            return;
            break;
        case 124:
            [self setCursorPosition: self.cursorPosition + 1]; // Right arrow key
            firstKey = false;
            break;
        case 123:
            [self setCursorPosition: self.cursorPosition - 1]; // Left arrow key
            firstKey = false;
            break;
    }

    if(firstKey) {
        firstKey = false;
        if([event keyCode] == 51 || [self.stringValue isEqualTo: self.nullString]) {
            self.stringValue = @"";
            self.cursorPosition = 0;
        }
    }
    
    NSString *characters;
    characters = [event characters];

    NSLog(@"Letter: %@", event);
    NSLog(@"KeyCode: %hu %@", [event keyCode], _invalidChars);

    if([characters rangeOfCharacterFromSet: _invalidChars].location == NSNotFound) {
        NSLog(@"Letter: %@", characters);
        NSLog(@"String length: %@", [NSNumber numberWithInt: [self.stringValue length]]);
        if([self.stringValue length] < self.maxLength) {
            NSLog(@"addingletter");
            [self addCharacter: characters];
        }
    }
    
    [self setNeedsDisplay:YES];
    
}

-(void)addCharacter:(NSString*)letter {
    NSMutableString *newString = [self.stringValue mutableCopy];
    [newString insertString:letter atIndex:_cursorPosition];
    [self setStringValue: newString];
    self.cursorPosition++;
    [self setNeedsDisplay:YES];
}

-(void)removeCharacter {
    if([self.stringValue length]) {
        NSMutableString *newString = [self.stringValue mutableCopy];
        [newString deleteCharactersInRange:NSMakeRange(_cursorPosition-1, 1)];
        [self setStringValue: newString];
        self.cursorPosition--;
        [self setNeedsDisplay:YES];
    }
}

-(void)deselect:(NSNotification*)notification  {
    if(self.isEditing) {
        [self.window makeFirstResponder:nil];
        [self setIsEditing: NO];
        
        if([self.stringValue isEqual:@""]) {
            self.stringValue = self.nullString;
        }
        
        self.savedString = self.stringValue;
        NSLog(@"Saved string: %@", self.savedString);

        firstKey = true;
        
        [self deselectHook];

        [self setNeedsDisplay:YES];
    }
}

-(void)deselectHook {
    // To be overwritten
}


@end

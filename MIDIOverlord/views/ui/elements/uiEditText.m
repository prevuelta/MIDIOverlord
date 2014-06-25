//
//  uiEditText.m
//  MIDIOverlord
//
//  Created by Pablo on 14/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiEditText.h"

@implementation uiEditText

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    _isEditable = NO;

    
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    
    if(self.isEditing) {
        self.textColor = [global sharedGlobalData].activeColor;
        self.bgColor = [global sharedGlobalData].defaultColor;
    } else {
         self.bgColor = [global sharedGlobalData].blackColor;
    }
    
    [super drawRect:dirtyRect];
    
    if(self.isEditing) {
        NSBezierPath *outline = [NSBezierPath new];
        NSBezierPath *cursor = [NSBezierPath new];
        
        int offset1 = (self.charSizeX * self.charCount) + self.padding ;
        int offset2 = (self.charSizeX * (self.charCount+1)) + self.padding - self.letterSpacing;
        
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
        
        [[global sharedGlobalData].activeColor set];
        [outline fill];
        [cursor fill];
    }
}

- (void)mouseUp:(NSEvent *)event {
    NSInteger clickCount = [event clickCount];
    if (2 == clickCount) [self handleDoubleClick:event];
}

-(void)handleDoubleClick:(NSEvent *)e {
    [global deselectNotify];
    NSLog(@"Editing textg");
    _tempString = self.stringValue;
    self.stringValue = @"";

    [self setIsEditing: YES];
    [self setNeedsDisplay: YES];
    [self.window makeFirstResponder: self];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)performKeyEquivalent:(NSEvent *)event {
    return YES;
}

-(void)keyDown:(NSEvent *)event {
        NSString *characters;
        characters = [event characters];
    NSLog(@"Letter: %@", characters);
    NSLog(@"KeyCode: %hu", [event keyCode]);
    if([characters rangeOfCharacterFromSet:[global sharedGlobalData].invalidChars].location == NSNotFound) {
        NSLog(@"Letter: %@", characters);
        if([self.stringValue length] < self.maxLength) {
            NSLog(@"addingletter");
            [self addCharacter: characters];
        }
    }
    
    if([event keyCode] == 51) {
        [self removeCharacter];
    }
    if([event keyCode] == 36) {
        [self deselect:nil];
    }
}

-(void)addCharacter:(NSString*)letter {
    self.stringValue  = [self.stringValue stringByAppendingString: letter];
    NSLog(@"%@", self.stringValue);
    
    [self setNeedsDisplay:YES];
}

-(void)removeCharacter {
    self.stringValue = [self.stringValue substringToIndex:self.stringValue.length-(self.stringValue.length>0)];
    [self setNeedsDisplay:YES];
}

-(void)deselect:(NSNotification*)notification  {
    [self.window makeFirstResponder:nil];
    [self setIsEditing: NO];
    self.textColor = [global sharedGlobalData].markerColor;
    if([self.stringValue isEqual:@""]) {
        self.stringValue = _tempString;
    }
    [self setNeedsDisplay:YES];
}



@end

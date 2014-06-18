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
        
    }
    
    [super drawRect:dirtyRect];
    
    if(self.isEditing) {
        NSBezierPath *outline = [NSBezierPath new];
        
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
    }
}

- (void)mouseUp:(NSEvent *)event {
    NSInteger clickCount = [event clickCount];
    if (2 == clickCount) [self handleDoubleClick:event];
}

-(void)handleDoubleClick:(NSEvent *)e {
    [global deselectNotify];
    NSLog(@"Editing textg");
    [self setIsEditing: YES];
    [self setNeedsDisplay: YES];
//    [global setFirstResponder: self];
    [self.window makeFirstResponder: self];
    //    if(self.editable) {
    //        NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
    ////        baseY = location.y;
    //        [self setActive: YES];
    //    }
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
    [self setCharCount: (int)[self.stringValue length]];
    
    NSLog(@"%@", self.stringValue);
    
    [self setNeedsDisplay:YES];
}

-(void)removeCharacter {
    self.stringValue = [self.stringValue substringToIndex:self.stringValue.length-(self.stringValue.length>0)];
    [self setCharCount: (int)[self.stringValue length]];
    [self setNeedsDisplay:YES];
}

-(void)deselect:(NSNotification*)notification  {
    [self.window makeFirstResponder:nil];
    [self setIsEditing: NO];
    self.textColor = [global sharedGlobalData].markerColor;
    [self setNeedsDisplay:YES];
}



@end

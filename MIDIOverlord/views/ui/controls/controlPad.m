//
//  gmUIElement.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

@synthesize value = _value;

-(id)initWithSize:(NSPoint)size andValue: (NSNumber*)value andMinValue:(int)min andMaxValue:(int)max {
    
    _size = size;
    _min = min;
    _max = max;
    _range = max - min;
    
    controlText *padNote = [[controlText alloc] initWithLabel: @"|" andValue:@-1];
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.x, size.y + padNote.frameHeight + 2)];
    if(!self) return nil;
    
    [padNote setOrigin:NSMakePoint(0, 38)];
    
    [self bind:@"value" toObject:padNote withKeyPath:@"value" options:nil];
    
    _noteLabel = [[uiTextField alloc] initWithString: @"---" andMaxLength: 5 ];
    
    [_noteLabel setOriginWithX: 0 andY: 4];
    
    [_noteLabel setDrawBg: NO];
    
    [self addSubview: padNote];
    [self addSubview: _noteLabel];

    [self setValue: value];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, _size.x, _size.y) xRadius: 1 yRadius: 1];
    
    [btnPath closePath];
    
    if(self.active) {
        [[global sharedGlobalData].activeColor set];
    } else {
        [[global sharedGlobalData].bgColor set];
    }
    
    [btnPath fill];
    
}

-(NSNumber*)value {
    return _value;
}

-(void)setValue:(NSNumber*)value {
    _value = value;
    [_noteLabel setStringValue: [utilities noteName: [_value intValue]]];

}

-(void)mouseDown:(NSEvent *)theEvent {
    self.active = YES;
    [self setNeedsDisplay:YES];
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = NO;
    [self setNeedsDisplay:YES];
}

@end

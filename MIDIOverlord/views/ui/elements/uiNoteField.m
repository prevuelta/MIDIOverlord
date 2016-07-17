//
//  uiNoteField.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiNoteField.h"

@implementation uiNoteField

@synthesize noteValue = _noteValue;

-(id)initWithString:(NSString*)stringValue {
    
    self = [super initWithString: stringValue andMaxLength: 3];
    
    if (!self) return nil;
    
    return self;
}

-(NSNumber*)noteValue {
    return _noteValue;
}

-(void)setNoteValue:(NSNumber *)noteValue {
    NSString * noteString = [utilities noteName: [noteValue intValue]];
    [self setStringValue: noteString];
    _noteValue = noteValue;
}
@end

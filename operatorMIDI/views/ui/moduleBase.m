//
//  moduleBase.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "moduleBase.h"


@implementation moduleBase

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    controlText *midiValueText = [[controlText alloc] initWithFrame:NSMakeRect(8, 96, 48, 32): _midiValue];
    
    [midiValueText bind:@"value" toObject:self withKeyPath:@"self.midiValue" options:nil];
    
    [self addSubview:midiValueText];
    
    return self;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

// Event handlers
-(void)uiEvent:(char*)type {
    NSLog(@"UI Event:");
}

-(void)uiEvent:(char*)type withInt:(int)value {
    NSLog(@"Ui event with int: %d", value);
}

@end

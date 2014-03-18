//
//  controlSwitch.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlSwitch.h"

@implementation controlSwitch

-(id)initWithFrame:(NSRect)frame :(char)label {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    return self;
}

-(void)setLabel:(NSString*)text {
    
    NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0 , 50, 30)];
    
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setEditable:NO];
    [label setSelectable:NO];
    
    [label setStringValue: text];
    
    [self addSubview: label];
    
    [self setNeedsDisplay:YES];
}

@end

//
//  controlText.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 26/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlText.h"

@implementation controlText

-(id)initWithFrame:(NSRect)frame :(int)value {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    //    [self.label setEditable:false];
    [self setIntValue:value];
    
    _value = 13;
    
    return self;
}



@end

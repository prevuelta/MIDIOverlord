//
//  controlSlider.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlSlider.h"

@implementation controlSlider

-(id)initWithFrame:(NSRect)frame :(NSPoint)size :(NSPoint)offset :(int)min :(int)max {
    
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    _size = size;
    _offset = offset;
    _min = min;
    _max = max;

    return self;
    
}

-(void)drawRect:(NSRect)rect {
    
}

@end

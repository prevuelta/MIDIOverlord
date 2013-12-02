//
//  gmSlider.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 2/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "gmSlider.h"

@implementation gmSlider {
    
}

- (id)initWithFrame:(NSRect)frame {
     self = [super initWithFrame:frame];
    
    NSSlider *slider = [[NSSlider alloc] init];
    
    [self addSubview: slider];
    
    NSLog(@"initWithFrame");
    
    return self;
}


@end

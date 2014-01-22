//
//  controlPad.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    
    NSPoint p[] = {6, 6, 6, 54, 114, 54, 114, 6};
    
    self.pointArray = p;
    
    return self;
}

@end
 
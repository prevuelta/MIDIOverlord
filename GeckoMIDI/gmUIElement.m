//
//  gmUIElement.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "gmUIElement.h"

@implementation gmUIElement

- (id)init {
    
    _path = [NSBezierPath bezierPath];
    _bg = [NSColor blackColor];
    
    return [self init];
}

- (void)drawBox {
    if(_pointArr) {
        NSPoint origin = {0, 0};
        [_path moveToPoint: origin];
        [_path appendBezierPathWithPoints: _pointArr count: sizeof _pointArr];
    }
}

@end

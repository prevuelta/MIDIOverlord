//
//  gmUIElement.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "gmButton.h"

@implementation gmButton

- (id)initWithFrame:(NSRect)frame:(int)size:(NSPoint)offset {
    self = [super initWithFrame:frame];
    
    _path = [NSBezierPath bezierPath];
    _size = size;
    _offset = offset;
    _bg = [NSColor blackColor];
    
    [self drawBox];
    
    return self;
}

- (void)drawBox {
    
    NSPoint origin = {0, 0};
    NSPoint pointArr[] = {0, _size, _size, _size, _size, 0};
    
    [_path moveToPoint: origin];
    [_path lineToPoint:pointArr[0]];
    [_path lineToPoint:pointArr[1]];
    [_path lineToPoint:pointArr[2]];
    
    NSAffineTransform *translateTransform = [NSAffineTransform transform];
    [translateTransform translateXBy:_offset.x yBy:_offset.y ];
    [_path transformUsingAffineTransform: translateTransform];
    
    [_path closePath];
    
    [[NSColor redColor] set];
    [_path fill];

    
}

@end

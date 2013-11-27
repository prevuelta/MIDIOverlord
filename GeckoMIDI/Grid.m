//
//  grid.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "Grid.h"

@implementation Grid {
    // Test drawing here
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    NSLog(@"initWithFrame");
    return self;
}

static NSPoint tp[] = { 10, 10, 400, 100, 300, 200, 10, 150 };

- (void)drawRect:(NSRect)frame {
//    NSLog(@"Drawing...");
    [[NSColor redColor] set];
    
    NSBezierPath* path = [NSBezierPath bezierPath];
    
    [path moveToPoint:tp[0]];
    [path lineToPoint:tp[1]];
    [path lineToPoint:tp[2]];
    [path lineToPoint:tp[3]];
    [path closePath];
    [[NSColor yellowColor] set];
    [path fill];
    
    [[NSColor blackColor] set];
    [path stroke];
}

@end

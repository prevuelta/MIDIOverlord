//
//  controlPad.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

@synthesize pointArray = _pointArray;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    
//    NSPointArray _pointArray;
    //    NSPoint p[] = {6, 6, 6, 54, 114, 54, 114, 6};
    
    
    
    NSPoint pointArray[3];

    pointArray[0] = NSMakePoint(0, 0);
    pointArray[1] = NSMakePoint(50, 20);
    pointArray[2] = NSMakePoint(50, 100);
    
    _pointArray = (__bridge NSPointArray)(pointArray);
    
    NSLog(@"Init pad");
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* path = [NSBezierPath new];
    
    [path setLineWidth: 0.5];
    
    int count = (sizeof _pointArray);// count];
    
//    NSLog(@"Rendering pad %@", _pointArray);

//    [path moveToPoint:NSMakePoint(0, 0)];
//    [path lineToPoint:NSMakePoint(100, 100)];
    
    NSPoint pointArray[3];
    
    pointArray[0] = NSMakePoint(0, 0);
    pointArray[1] = NSMakePoint(50, 20);
    pointArray[2] = NSMakePoint(50, 100);
    
    [path appendBezierPathWithPoints:pointArray count:count];
    
    [path closePath];
    
    [[NSColor blackColor] set];
    
    [path stroke];
}

@end
 
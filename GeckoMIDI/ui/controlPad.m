//
//  controlPad.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad {
     NSPointArray pointArray;
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    

//    NSPoint p[] = {6, 6, 6, 54, 114, 54, 114, 6};
    
//    pointArray = p;

    pointArray[0] = NSMakePoint(0, 0);
    pointArray[1] = NSMakePoint(50, 20);
    pointArray[2] = NSMakePoint(50, 100);
    
    
    NSLog(@"Init pad");
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    

    
    NSBezierPath* path = [NSBezierPath new];
    
    [path setLineWidth: 0.5];

    int count = (sizeof pointArray);// count];
    
    NSLog(@"Rendering pad %@", pointArray);

//    NSPointArray pointArray = [self getPath]
    
    [path appendBezierPathWithPoints:pointArray count:count];

    [path closePath];

    [[NSColor blackColor] set];

    [path stroke];
}

//- (NSPointArray)getPath {
//
//    
////        return pointArray;
//}

@end
 
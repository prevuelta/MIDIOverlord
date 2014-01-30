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
    
    self.gridX = 2;
    self.gridY = 1;
    
//    [self setBounds:NSMakeRect(0, 0, 120, 120)];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* path = [NSBezierPath new];

    [path setLineWidth: 0.5];
    
    [[NSColor whiteColor] set];
    
    [path appendBezierPathWithRect:NSMakeRect(0, 0, 120, 120)];

    [path fill];
//    NSPoint pointArray[8] = {6, 6, 6, 54, 114, 54, 114, 6};

   NSLog(@"Rendering pad");
    
//    NSPoint pointArray[3];
//    
//    pointArray[0] = NSMakePoint(0, 0);
//    pointArray[1] = NSMakePoint(50, 20);
//    pointArray[2] = NSMakePoint(50, 100);
//
//    int count = [pointArray count];
    
    [path appendBezierPathWithRect:NSMakeRect(6, 6, 108, 48)];
//    [path appendBezierPathWithPoints:pointArray count:count];

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
 
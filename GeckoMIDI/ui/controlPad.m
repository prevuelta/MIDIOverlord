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
    
    NSBezierPath* bgPath = [NSBezierPath new];
    [[NSColor whiteColor] set];
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, 120, 120)];
    [bgPath closePath];
    [bgPath fill];
    
    NSBezierPath* padPath = [NSBezierPath new];

    [padPath setLineWidth: 0.5];
    
//
    
//

//
//    NSPoint pointArray[8] = {6, 6, 6, 54, 114, 54, 114, 6};

   NSLog(@"Rendering pad");
    
//    NSPoint pointArray[3];
//    
//    pointArray[0] = NSMakePoint(0, 0);
//    pointArray[1] = NSMakePoint(50, 20);
//    pointArray[2] = NSMakePoint(50, 100);
//
//    int count = [pointArray count];
    
    [padPath appendBezierPathWithRect:NSMakeRect(6, 6, 108, 48)];
//    [path appendBezierPathWithPoints:pointArray count:count];

    [padPath closePath];

    [[NSColor blackColor] set];

    [padPath fill];
    
    }

//- (NSPointArray)getPath {
//
//    
////        return pointArray;
//}

@end
 
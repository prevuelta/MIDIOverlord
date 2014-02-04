//
//  controlPad.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.gridX = 2;
    self.gridY = 1;
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    [[NSColor whiteColor] set];
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, 128, 128)];
    [bgPath closePath];
    [bgPath fill];
    
    NSBezierPath* padPath = [NSBezierPath new];

    [padPath setLineWidth: 0.5];
    

   NSLog(@"Rendering pad");
    
    [padPath appendBezierPathWithRect:NSMakeRect(8, 8, 112, 52)];

    [padPath closePath];

    [[NSColor blackColor] set];

    [padPath fill];
    
    }

@end
 
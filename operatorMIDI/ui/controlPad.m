//
//  controlPad.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

- (id)initWithFrame{
    
    NSRect frame = NSMakeRect(0, 0, 64, RACK_HEIGHT );
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.gridX = 2;
    self.gridY = 1;
    
    self.width = 64;
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    [[NSColor grayColor] set];
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, RACK_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];
    
    NSBezierPath* padPath = [NSBezierPath new];

    [padPath setLineWidth: 0.5];
    

   NSLog(@"Rendering pad");
    
    [padPath appendBezierPathWithRect:NSMakeRect(8, 8, self.width - 16, 52)];

    [padPath closePath];

    [[NSColor blackColor] set];

    [padPath fill];
    
    }

@end
 
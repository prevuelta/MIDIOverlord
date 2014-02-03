//
//  gmSlider.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 2/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlSlider.h"

static int height = 100;
static int width = 30;

//static NSPoint rbackgroundRect[] = { 0, 0, 0, height, width, height, width, 0 };


@implementation controlSlider

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    
//    _height = 100;
//    _width = 30;
    
//    backgroundRect = [0, 0, 0, _height, _width, _height, _width, 0];

//    NSLog((__bridge id)(backgroundRect));
    
    NSSlider *slider = [[NSSlider alloc] initWithFrame: NSMakeRect(10.0, 10.0, width, height)];
    
    [self addSubview: slider];
    
    NSLog(@"initGMSlider");
    
    return self;

}

- (void)drawRect:(NSRect)frame {
    
    NSLog(@"Drawing slider...");
    
    [[NSColor redColor] set];
    
     NSBezierPath* path = [NSBezierPath bezierPath];
    
//	[path moveToPoint:backgroundRect[0]];
//	[path lineToPoint:backgroundRect[1]];
//	[path lineToPoint:backgroundRect[2]];
//    [path lineToPoint:backgroundRect[3]];
    [path closePath];
    [[NSColor brownColor] set];
    [path fill];

}

@end

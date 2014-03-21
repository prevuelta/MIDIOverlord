//
//  controlDeviceList.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlDeviceList.h"

@implementation controlDeviceList

-(id)initWithFrame:(NSRect)frame :(NSMutableArray*)devices {
    self = [super initWithFrame:frame];
    
    if(!self) return nil;

    for(int i = 0; i < [devices count]; i++) {
        controlSwitch *device = [[controlSwitch alloc] initWithFrame: NSMakeRect(0, 0, 50, 10)];
        [device setLabel: devices[i]];
        [self addSubview: device];
    }

    if(![devices count]) {
        controlSwitch *empty = [[controlSwitch alloc] initWithFrame: NSMakeRect(0, 0, 50, 10)];
        [empty setLabel: @"No outputs"];
        [self addSubview: empty];
    }

    [self setNeedsDisplay:YES];
    
    return self;
}

-(void)drawRect:(NSRect)rect {
    NSBezierPath* bgPath = [NSBezierPath new];
    
    float bgRGBA[] = UI_COLOR_PROT_3;
    
    NSColor* bgColor = [utilities getNSColorFromRGB:bgRGBA];
    
    [bgColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, 80, RACK_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];
}

@end

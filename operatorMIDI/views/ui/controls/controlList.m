//
//  controlList.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlList.h"

@implementation controlList


-(id)initWithFrame:(NSRect)frame :(NSMutableArray*)keyValues{
    
    self.width = 800;
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;

    
    for(int i = 0; i < [keyValues count]; i++ ) {
        
        if(i % 2 == 0) {
            uiLabel *label = [[uiLabel alloc] initWithFrame: NSMakeRect(100, 50, 100, 30)];
            [label setStringValue: keyValues[i]];
            [self addSubview:label];
        
        } else {
        
        }
    }
    
    [self setNeedsDisplay:YES];
    
    return self;
}

-(void)drawRect:(NSRect)rect {
    NSBezierPath* bgPath = [NSBezierPath new];
    
    float bgRGBA[] = UI_COLOR_PROT_3;
    
    NSColor* bgColor = [utilities getNSColorFromRGB:bgRGBA];
    
    [bgColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(100, 0, self.width, 300)];
    [bgPath closePath];
    [bgPath fill];
}

-(BOOL)isFlipped {
    return YES;
}

@end

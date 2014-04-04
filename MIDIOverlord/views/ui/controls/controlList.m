//
//  controlList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlList.h"

@implementation controlList


-(id)initWithFrame:(NSRect)frame :(NSMutableArray*)keyValues{
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    _selected = [NSMutableArray arrayWithObjects:@"None", @0, nil];
    
    _height = RACK_HEIGHT - MODULE_HEIGHT;
    
    uiLabel *label = [[uiLabel alloc] initWithFrame: NSMakeRect(40, 0, 150, _height)];
    [label setStringValue: @"Midi Output: "];
    [self addSubview:label];
    
    label = [[uiLabel alloc] initWithFrame: NSMakeRect(100, 0, 150, _height)];
    [label setStringValue: _selected[0]];
    [self addSubview:label];
    
    
    NSLog(@"Key values: %@", keyValues);


    for(int i = 0; i < [keyValues count]; i++ ) {
        
        if(i % 2 == 0) {
            uiLabel *label = [[uiLabel alloc] initWithFrame: NSMakeRect(100, (i+1) * _height , 150, _height)];
            [label setStringValue: keyValues[i]];
            [self addSubview:label];
        
        } else {
        
        }
    }
    
    return self;
}

-(void)drawRect:(NSRect)rect {
    NSBezierPath* bgPath = [NSBezierPath new];
    
    float bgRGBA[] = UI_COLOR_PROT_3;
    
    NSColor* bgColor = [utilities getNSColorFromRGB:bgRGBA];
    
    [bgColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(100, 0, 150, _height)];
    [bgPath closePath];
    [bgPath fill];
}

@end

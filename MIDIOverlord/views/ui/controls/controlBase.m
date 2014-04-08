//
//  controlBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@implementation controlBase

-(void)setDefaults {
    
    NSLog(@"Control init");
    
    float defaultRGBA[] = UI_COLOR_PROT_3;
    float markerRGBA[] = UI_COLOR_PROT_4;
    float activeRGBA[] = UI_COLOR_HIGHLIGHT;
    
    _defaultColor = [utilities getNSColorFromRGB:defaultRGBA];
    _markerColor = [utilities getNSColorFromRGB:markerRGBA];
    _activeColor = [utilities getNSColorFromRGB:activeRGBA];

}


-(void)remove {
    NSLog(@"remove function");
}

-(BOOL)isFlipped {
    return NO;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}



@end

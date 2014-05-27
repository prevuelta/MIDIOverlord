//
//  controlBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@implementation controlBase
@synthesize tag = _tag;

-(void)setDefaults {
    
    NSLog(@"Control init");
    
    float blackRGBA[] = UI_COLOR_BLACK;
    float defaultRGBA[] = UI_COLOR_PROT_2;
    float markerRGBA[] = UI_COLOR_HIGHLIGHT;
    float activeRGBA[] = UI_COLOR_HIGHLIGHT_2;
    
    _defaultColor = [utilities getNSColorFromRGB:defaultRGBA];
     _blackColor = [utilities getNSColorFromRGB:blackRGBA];
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

//-(NSInteger)tag {
//    return _tag;
//}
//
//-(void)setTag:(NSInteger)tag {
//    _tag = tag;
//}


-(void)deselect:(NSNotification*)notification  {
    NSLog(@"THISHAPE");
    _selected = NO;
    [self setNeedsDisplay:YES];
}
//
//


@end


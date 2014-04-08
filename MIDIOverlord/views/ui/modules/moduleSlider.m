//
//  moduleSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleSlider.h"

@implementation moduleSlider

@synthesize midiValue = _midiValue;

-(id)initWithFrame{
    
    int width = 80;
    
    NSRect frame = NSMakeRect(0, 0, width, MODULE_HEIGHT);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.value = 0;
    self.width = width;
    
    // Add UI buttons
    
    // Add UI buttons
    float sliderRGBA[] = UI_COLOR_PROT_3;
    NSColor* sliderColor = [utilities getNSColorFromRGB:sliderRGBA];
    
    controlSlider *slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width - 16, self.width - 16): NSMakePoint(8, 8): sliderColor :0 :127 ];
    
    slider.delegate = self;
    
    [self addSubview: slider];
    
    return self;
}

-(void)drawModule:(NSRect)rect {
    
    NSLog(@"%d", _midiValue);
    
}

@end

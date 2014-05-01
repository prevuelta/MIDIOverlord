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
    
    self.value = 0;
    self.width = 60;

    self = [super initWithFrame:NSMakeRect(0, 0, self.width, MODULE_HEIGHT)];
    
    if(!self) return nil;
    
    // Add UI buttons
    
    // Add UI buttons
    float sliderRGBA[] = UI_COLOR_PROT_3;
    NSColor* sliderColor = [utilities getNSColorFromRGB:sliderRGBA];
    
    controlSlider *slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width - 16, 80): NSMakePoint(8, 8): sliderColor :0 :127 ];
    
    slider.delegate = self;
    
    [self addSubview: slider];
    
    return self;
}

-(void)drawModule:(NSRect)rect {
    
    NSLog(@"%d", _midiValue);
    
}

@end

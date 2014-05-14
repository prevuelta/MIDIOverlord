//
//  moduleSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleSlider.h"

@implementation moduleSlider

-(id)initWithFrame{
    
    self.value = 0;
    self.width = 60;

    self = [super initWithFrame:NSMakeRect(0, 0, self.width, MODULE_HEIGHT)];
    
    if(!self) return nil;
    
    self.midiV1 = 176;
    self.midiV2 = 0;
    self.midiV3 = 0;
    
    // Add UI buttons
    
    // Add UI buttons
    float sliderRGBA[] = UI_COLOR_PROT_3;
    NSColor* sliderColor = [utilities getNSColorFromRGB:sliderRGBA];
    
    controlSlider *slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width, 128): NSMakePoint(0, 0): sliderColor :0 :127 ];

    [self bind:@"midiV3" toObject:slider withKeyPath:@"value" options:nil];
    
    [self addSubview: slider];
    
    return self;
}

-(void)drawModule:(NSRect)rect {
    
//    NSLog(@"Slide val: %@", [NSNumber numberWithInt:self.midiV2]);
    
}


@end

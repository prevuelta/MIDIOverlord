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
    self.height = 24;

    self = [super initWithFrame:NSMakeRect(0, 0, RACK_WIDTH, self.height)];
    
    if(!self) return nil;
    
    self.midiV1 = 0;
    self.midiV2 = 0;
    self.midiV3 = 0;
    
    
    
    controlText *midiValueText = [[controlText alloc] initWithFrame: self.midiV1 andLabel: @"CC" andMaxVal:127];
    
    [midiValueText setOrigin:NSMakePoint(0, 12)];
    
    [midiValueText setEditable:YES];
    
    // Add UI buttons
    
    // Add UI buttons
    
    controlSlider *slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width, 12): NSMakePoint(0, 0): 0 :127 ];
    
    [slider setOrigin:NSMakePoint(0, 0)];

    [self bind:@"midiV3" toObject:slider withKeyPath:@"value" options:nil];
    
    [self addSubview: slider];
    
    [self addCCField];
    
    return self;
}

-(void)drawModule:(NSRect)rect {
    
//    NSLog(@"Slide val: %@", [NSNumber numberWithInt:self.midiV2]);
    
}


@end

//
//  modulePad.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

@synthesize midiValue = _midiValue;

- (id)initWithFrame{
    
    int width = 80;
    
    NSRect frame = NSMakeRect(0, 0, width, RACK_HEIGHT );
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.width = width;
    
    _midiValue = 122;
    
    controlTrigger *pad = [[controlTrigger alloc] initWithFrame:NSMakePoint(self.width - 16, self.width - 16): NSMakePoint(8, 8)];
    
    pad.delegate = self;
    
    [self addSubview: pad];
    
    controlText *midiValueText = [[controlText alloc] initWithFrame:NSMakeRect(8, 96, 48, 32):_midiValue];
    
    [midiValueText bind:@"value" toObject:self withKeyPath:@"self.midiValue" options:nil];
    
    [self addSubview:midiValueText];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSLog(@"%d", _midiValue);
    
    NSBezierPath* bgPath = [NSBezierPath new];
    
    float bgRGBA[] = UI_COLOR_PROT_1;

    NSColor* bgColor = [utilities getNSColorFromRGB:bgRGBA];
    
    [bgColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, RACK_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];
    
}

@end
 
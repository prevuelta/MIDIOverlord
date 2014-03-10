//
//  modulePad.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePad.h"

@implementation modulePad

- (id)initWithFrame{
    
    int width = 80;
    
    NSRect frame = NSMakeRect(0, 0, width, RACK_HEIGHT );
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.gridX = 2;
    self.gridY = 1;
    
    self.width = width;
    
    _midiNote = 122;
    
    // Add UI buttons
    float padRGBA[] = DARK_GREY_ALT;
    NSColor* padColor = [utilities getNSColorFromRGB:padRGBA];
    
    controlTrigger *pad = [[controlTrigger alloc] initWithFrame:NSMakePoint(self.width - 16, self.width - 16): NSMakePoint(8, 8): padColor ];
    
    pad.delegate = self;
    
    [self addSubview: pad];
    
    controlText *midiNoteValue = [[controlText alloc] initWithFrame:NSMakeRect(8, 96, 48, 32):_midiNote];
    
//    [midiNoteValue bind:@"midNote" toObject:self withKeyPath:@"selection.midiNote" options:nil];
    
    [self addSubview:midiNoteValue];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    
    float bgRGBA[] = DARK_GREY;

    NSColor* bgColor = [utilities getNSColorFromRGB:bgRGBA];
    
    [bgColor set];
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, RACK_HEIGHT)];
    [bgPath closePath];
    [bgPath fill];
    
}

@end
 
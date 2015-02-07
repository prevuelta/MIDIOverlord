//
//  uiIndicator.m
//  MIDIOverlord
//
//  Created by Pablo on 7/02/2015.
//  Copyright (c) 2015 Midnight City. All rights reserved.
//

#import "uiIndicator.h"

@implementation uiIndicator

-(id)init {
    self = [super initWithFrame:NSMakeRect(0, 0, BASE_UNIT, BASE_UNIT)];
    if(!self) return nil;
    
    _type = 1;

    NSArray *typeColors = @[
        @"red",
        @"yellow"
    ];
    
    self.defaultColor = [global sharedGlobalData].colors[@"black"];
    self.activeColor = [global sharedGlobalData].colors[typeColors[_type]];
    
    return self;
}

-(void)ping {
    [self setActive: YES];
    [self setNeedsDisplay: YES];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(fade) userInfo:nil repeats:NO];
}

-(void)fade {
    NSLog(@"Faded");
    [self setActive: NO];
    [self setNeedsDisplay: YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    
    [self.defaultColor setFill];
    
    NSRectFill(dirtyRect);
    
    [super drawRect:dirtyRect];
    
    if(self.active) {
        [self.activeColor setFill];
        NSBezierPath* markerPath = [NSBezierPath new];
        [markerPath appendBezierPathWithOvalInRect: NSMakeRect(6, 6, BASE_UNIT / 4, BASE_UNIT / 4)];
        [markerPath fill];
    }
    
}

@end

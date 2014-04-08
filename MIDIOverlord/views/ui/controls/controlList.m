//
//  controlList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlList.h"

@implementation controlList


-(id)initWithFrame: (NSMutableArray*)keyValues andLabel:(NSString*)labelText andDefault:(NSString*)defaultText{
    
    self.width = 120;
    self.height = RACK_HEIGHT - MODULE_HEIGHT;
    
    NSRect frame = NSMakeRect(0, 0, self.width, self.height * ([keyValues count]+1));
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;

    _selected = [NSMutableArray arrayWithObjects:@"None", @0, nil];
    
    _height = RACK_HEIGHT - MODULE_HEIGHT;
    
    float bgRGBA[] = UI_COLOR_PROT_2;
    float activeBgRGBA[] = UI_COLOR_PROT_3;
    float fgRGBA[] = UI_COLOR_PROT_4;
    
    _bgColor = [utilities getNSColorFromRGB:bgRGBA];
    _activeBgColor = [utilities getNSColorFromRGB:activeBgRGBA];
    _fgColor = [utilities getNSColorFromRGB:fgRGBA];
    
    uiLabel *label = [[uiLabel alloc] initWithFrame: NSMakeRect(0, 0, self.width, self.height)];
    [label setStringValue: labelText];
    [self addSubview:label];
    
    label = [[uiLabel alloc] initWithFrame: NSMakeRect(60, 0, 150, _height)];
    [label setStringValue: _selected[0]];
    [self addSubview:label];
    
    
    NSLog(@"Key values: %@", keyValues);


    for(int i = 0; i < [keyValues count]; i++ ) {
        
        if(i % 2 == 0) {
            uiLabel *label = [[uiLabel alloc] initWithFrame: NSMakeRect(60, (i+1) * self.height , self.width, self.height)];
            [label setDrawsBackground:YES];
            [label setStringValue: keyValues[i]];
            [label setTag: 5];
            [label setHidden:YES];
            [self addSubview:label];
        
        } else {
        
        }
    }
    
    return self;
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    if(self.active) {
        [_activeBgColor set];
    } else {
        [_bgColor set];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(60, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];
    
    [_fgColor set];
    
    [fgPath moveToPoint:NSMakePoint(self.width-15, 5)];
    [fgPath lineToPoint:NSMakePoint(self.width-5, 5)];
    [fgPath lineToPoint:NSMakePoint(self.width-10, 10)];
    
    [fgPath closePath];
    [fgPath fill];
}

-(BOOL)isFlipped {
    return YES;
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"Whats up");
    self.active = !self.active;
    if(self.active) {
        NSLog(@"active");
//            [self removeFromSuperview];
//        [self.superview addSubview:self];
        [self.superview addSubview:self positioned:NSWindowAbove relativeTo:nil];
    } else {
                NSLog(@"Notactive");
        //        [self.superview addSubview:self];
//        [self.superview addSubview:self positioned:NSWindowBelow relativeTo:nil];
    }
    [[self viewWithTag: 5] setHidden: !self.active];
    [self setNeedsDisplay:YES];
}


@end

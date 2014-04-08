//
//  rack.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleRack.h"

@implementation moduleRack

@synthesize data = _data;
@synthesize subViews;

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.width = WINDOW_WIDTH;
    
    self.height = RACK_HEIGHT;
    
    [self addRackTitle];
    
    float bgRGBA[] = UI_COLOR_PROT_0;
    
    self.bgColor = [utilities getNSColorFromRGB: bgRGBA];
    
    self.subViews = [NSMutableArray new];
    
    return self;
}

-(void)addRackTitle {

    self.label = [[uiLabel alloc] initWithFrame:self.frame];
    
    [self.label setStringValue: self.labelText];
    
    [self addSubview: self.label];
    
    // Destinations
    NSMutableArray* destinations = [utilities getMidiDestinations];
    controlList *midiOutput = [[controlList alloc] initWithFrame: destinations andLabel: @"Midi OUT" andDefault: @"None"];
    [midiOutput setOrigin: NSMakePoint(100, 0)];
    [self addSubview: midiOutput positioned:NSWindowAbove relativeTo:nil];
    
    // Origins
    NSMutableArray* sources = [utilities getMidiSources];
    controlList *midiInput = [[controlList alloc] initWithFrame:sources andLabel: @"Midi IN" andDefault: @"None"];
    [midiInput setOrigin: NSMakePoint(240, 0)];
    [self addSubview: midiInput positioned:NSWindowAbove relativeTo:nil];
    
    [self setNeedsDisplay:YES];
    
}
//
-(NSDictionary*)data {
    return _data;
}

-(void)setData:(NSDictionary*)data {
    self.labelText = [data objectForKey: @"label"];
    self.tag = [[data objectForKey:@"ID"] integerValue];
    _data = data;
}

-(BOOL)isFlipped {
    return YES;
}

-(void)drawBg:(NSRect)rect {
    
    // Draw background
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    int strokeWidth = 4;
    
    if(self.selected) {
        [self.selectedColor set];
    } else {
        [self.bgColor set];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, RACK_HEIGHT - MODULE_HEIGHT)];
    
    [bgPath closePath];
    [bgPath fill];
    
    [fgPath moveToPoint:NSMakePoint(self.width - (strokeWidth/2), RACK_HEIGHT - MODULE_HEIGHT)];
    [fgPath lineToPoint:NSMakePoint(self.width - (strokeWidth/2), RACK_HEIGHT - (strokeWidth/2))];
    [fgPath lineToPoint:NSMakePoint(strokeWidth / 2, RACK_HEIGHT - (strokeWidth/2))];
    [fgPath lineToPoint:NSMakePoint(strokeWidth / 2, RACK_HEIGHT - MODULE_HEIGHT)];
    
    [fgPath setLineWidth: strokeWidth];
    
    [fgPath stroke];
    
    NSLog(@"Drawing");
}


@end
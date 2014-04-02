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

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.width = WINDOW_WIDTH;
    
    self.height = RACK_HEIGHT;
    
    [self addRackTitle];
    
    float bgRGBA[] = UI_COLOR_PROT_0;
    
    self.bgColor = [utilities getNSColorFromRGB: bgRGBA];
    
    return self;
}

-(void)addRackTitle {

    self.label = [[uiLabel alloc] initWithFrame:self.frame];
    
    [self.label setStringValue: self.labelText];
    
    [self addSubview: self.label];
    
    NSMutableArray* destinations = [utilities getMidiDestinations];
    
    controlList *midiOutput = [[controlList alloc] initWithFrame: NSMakeRect(0, 0, 600, 200): destinations];
    
    [self addSubview: midiOutput];
    
    [self setNeedsDisplay:YES];
    
}
//
-(NSDictionary*)data {
    return _data;
}

-(void)setData:(NSDictionary*)data {
    self.labelText = [data objectForKey: @"label"];
    _data = data;
}


@end
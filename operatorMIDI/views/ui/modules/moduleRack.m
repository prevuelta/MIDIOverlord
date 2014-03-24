//
//  rack.m
//  operatorMIDI
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
    
    self.bgColor = UI_COLOR_PROT_0;
    
    [self addRackTitle];
    
    
    return self;
}

-(void)addRackTitle {

    self.label = [[uiLabel alloc] initWithFrame:NSMakeRect(0, RACK_HEIGHT, 20, 80)];
    
    [self.label setStringValue: @"Untitled"];
    
    [self addSubview: self.label];
    
    NSMutableArray* destinations = [utilities getMidiDestinations];
    
    controlDeviceList *midiOutput = [[controlDeviceList alloc] initWithFrame: NSMakeRect(0, 0, self.width, RACK_HEIGHT) :destinations];
    
//    [self addSubview: midiOutput];
    
    [self setNeedsDisplay:YES];
    
}
//
-(NSDictionary*)data {
    return _data;
}

-(void)setData:(NSDictionary*)data {
    self.label = [data objectForKey: @"label"];
    _data = data;
}




@end
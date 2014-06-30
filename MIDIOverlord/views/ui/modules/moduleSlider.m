//
//  moduleSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleSlider.h"

@implementation moduleSlider

@synthesize midiByte2 = _midiByte2;
@synthesize data = _data;

-(id)initWithData:(NSMutableDictionary*)data {
    
    _value = 0;
    self.height = 20;
    _data = data;
    
    self = [super initWithFrame:NSMakeRect(0, 0, RACK_WIDTH - SCROLLER_WIDTH, self.height)];
    
    if(!self) return nil;
    
    NSLog(@"Data received: %@", data);
    
    self.midiStatusByte = [data objectForKey: @"midiStatusByte"];
    self.midiByte1 = [data objectForKey:@"midiByte1"];
    self.midiByte2 = [data objectForKey:@"midiByte2"];
    
    NSLog(@"Init with data");
    
    // Add Slider
    _slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width, 20): NSMakePoint(0, 0): 0 :127 ];
    [_slider setOrigin:NSMakePoint(0, 1)];
    [_slider updateControlFromData: data[@"midiByte2"]];

    [_data bind:@"midiByte2" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];

    // Add Label
    uiEditText *label = [[uiEditText alloc] initWithString: _data[@"label"] andMaxLength: 4 andLabelLength: 0];
    [label setOrigin:NSMakePoint(2, 2)];
    [label setInEditView:YES];
    
    [_data bind:@"label" toObject: label withKeyPath:@"stringValue" options:nil];
    
    [self addSubview:label];
    
    // Add CC text field
    _midiByte1Control = [[controlText alloc] initWithString: @"CC000"];
    
    [_midiByte1Control setOrigin:NSMakePoint(label.frameWidth + 2, 2)];
    [_midiByte1Control setInEditView:YES];
    [_midiByte1Control setMax:127];
    [_midiByte1Control setValue: data[@"midiByte1"]];
    
    [_data bind:@"midiByte1" toObject: _midiByte1Control withKeyPath:@"value" options:nil];
    
    [self addSubview: _midiByte1Control];

    // Add close button
    uiButtonClose *removeBtn = [[uiButtonClose alloc] initWithSize: 8];
    [removeBtn setEvent:@"removeModule" withData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 20 - SCROLLER_WIDTH, 6)];
    [removeBtn setInEditView:YES];
    
    [self addSubview: removeBtn];
    
    return self;
}

-(void)drawModule:(NSRect)rect {

//    NSBezierPath *bgPath = [NSBezierPath new];
    
//    [bgPath moveToPoint: NSZeroPoint];
//    [bgPath lineToPoint: NSMakePoint(self.width, 0)];
//    [bgPath lineToPoint: NSMakePoint(self.width, 1)];
//    [bgPath lineToPoint: NSMakePoint(0, 1)];

//     [bgPath closePath];
    
//    [[global sharedGlobalData].bgColor set];
//    [bgPath fill];
}


-(NSNumber*)midiByte2 {
    return _midiByte2;
}

-(void)setMidiByte2:(NSNumber*)midiByte2 {
    _midiByte2 = midiByte2;
    [self.delegate midiData: @[self.midiStatusByte, self.midiByte1, self.midiByte2]];
    [self updateModel];
}

-(NSMutableDictionary*)data {
    return _data;
}


@end

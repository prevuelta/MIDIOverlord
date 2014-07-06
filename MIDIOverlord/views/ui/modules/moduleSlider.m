//
//  moduleSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleSlider.h"

@implementation moduleSlider

@synthesize ccValue = _ccValue;
@synthesize data = _data;

-(id)initWithData:(NSMutableDictionary*)data {
    
    _ccValue = 0;
    
    self.height = 24;
    
    _data = data;
    
    self = [super initWithFrame:NSMakeRect(0, 0, RACK_WIDTH - SCROLLER_WIDTH, self.height)];
    
    if(!self) return nil;
    
    NSLog(@"Data received: %@", data);
//    
//    self.midiStatusByte = [data objectForKey: @"midiStatusByte"];
//    self.midiByte1 = [data objectForKey:@"midiByte1"];
//    self.midiByte2 = [data objectForKey:@"midiByte2"];
//    
    NSLog(@"Init with data");
    
    // Add Slider
    _slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width - 4, 20): NSMakePoint(0, 0): 0 :127 ];
    [_slider setOrigin:NSMakePoint(2, 2)];
    [_slider updateControlFromData: data[@"ccValue"]];
    
    [self bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];

    // Add Label
    uiEditText *editLabel = [[uiEditText alloc] initWithString: _data[@"label"] andMaxLength: 4 andLabelLength: 0];
    [editLabel setOrigin:NSMakePoint(4, 4)];
    [editLabel setInEditView:YES];
    
    [_data bind:@"label" toObject: editLabel withKeyPath:@"stringValue" options:nil];
    
    [self addSubview:editLabel];

    [_slider.label bind:@"stringValue" toObject: _data withKeyPath:@"label" options:nil];
    
    // Add CC text field
    
    _ccControl = [[controlText alloc] initWithLabel: @"CC"];
    
    [_ccControl setOrigin:NSMakePoint(editLabel.frameWidth + 4, 4)];
    [_ccControl setInEditView:YES];
    [_ccControl setMax:127];
    [_ccControl setValue: data[@"ccNumber"]];
    
    [_data bind:@"ccNumber" toObject: _ccControl withKeyPath:@"value" options:nil];
    
    [self addSubview: _ccControl ];

    // Add close button
    uiButtonClose *removeBtn = [[uiButtonClose alloc] initWithSize: 24];
    [removeBtn setEvent:@"removeModule" withData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 24 - SCROLLER_WIDTH -8, 0)];
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


-(NSNumber*)ccValue {
    return _ccValue;
}

-(void)setCcValue:(NSNumber*)ccValue {
    NSLog(@"Set ccValue");
    _ccValue = ccValue;
    [self.delegate midiData: @[self.data[@"ccStatus"], self.data[@"ccNumber"], self.data[@"ccValue"]]];
}


@end

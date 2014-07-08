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
    
    self.height = 32;
    
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
    _slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width, 16): 0 :127 ];
    [_slider setOrigin:NSMakePoint(0, 0)];
    [_slider updateControlFromData: data[@"ccValue"]];
    
    [self bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];

    // Add Label
    uiEditableTextField *editLabel = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 8];
    [editLabel setOrigin:NSMakePoint(0, 16)];
//    [editLabel setInEditView:YES];
    
    [_data bind:@"label" toObject: editLabel withKeyPath:@"savedString" options:nil];
    
    [self addSubview:editLabel];

    // [_slider.label bind:@"stringValue" toObject: _data withKeyPath:@"label" options:nil];
    
    // Add CC text field
    
    _ccControl = [[controlText alloc] initWithLabel: @"CC" andValue: data[@"ccValue"]];
    
   [_ccControl setOrigin:NSMakePoint(editLabel.frameWidth + 2, 16)];
   [_ccControl setMax:127];
    
   [_data bind:@"ccNumber" toObject: _ccControl withKeyPath:@"value" options:nil];
    
   [self addSubview: _ccControl ];

    // Add close button
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 16];
    [removeBtn setEvent:@"removeModule" withData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 16 - SCROLLER_WIDTH -8, 16)];
//    [removeBtn setInEditView:YES];
    
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

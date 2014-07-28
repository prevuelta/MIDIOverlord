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
    
    int height = 32;
    
    self = [super initWithHeight: height];
    
    if(!self) return nil;
    
    _ccValue = 0;
    
    _data = data;
    
    NSLog(@"Data received: %@", data);
    
    // Add Slider
    _slider = [[controlSlider alloc] initWithSize:NSMakePoint(self.width, 16) andValue: data[@"ccValue"] andMinValue: 0 andMaxValue:127 ];
    [_slider setOrigin:NSMakePoint(0, 0)];
    
    [self bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];

    // Add Label
    uiEditableTextField *editLabel = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 8];
    [editLabel setOrigin:NSMakePoint(14, 16)];
    
    [_data bind:@"label" toObject: editLabel withKeyPath:@"savedString" options:nil];
    
    [self addSubview:editLabel];

    _ccControl = [[controlText alloc] initWithLabel: @"CC" andValue: data[@"ccNumber"]];
    
   [_ccControl setOrigin:NSMakePoint(editLabel.frameWidth + 16, 16)];
   [_ccControl setMax:127];
    
   [_data bind:@"ccNumber" toObject: _ccControl withKeyPath:@"value" options:nil];
    
   [self addSubview: _ccControl ];

    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12];
    [removeBtn setEvent:@"removeModule" withData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(self.width - 20, 18)];
    
    [self addSubview: removeBtn];
    
    
    uiButton *mapBtn = [[uiButton alloc] initWithSize: 12];
    [mapBtn setEvent:@"mapRecord" withData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [mapBtn setIsToggle: YES];
    [mapBtn setOrigin: NSMakePoint(0, 18)];
    
    [self addSubview: mapBtn];
    
    return self;
}

-(NSNumber*)ccValue {
    return _ccValue;
}

-(void)setCcValue:(NSNumber*)ccValue {
    _ccValue = ccValue;
    if(![self.data[@"ccNumber"] isEqualToNumber:@-1]) {
        [self.delegate midiCommand: @[self.data[@"ccStatus"], self.data[@"ccNumber"], self.data[@"ccValue"]]];
    }
}


@end

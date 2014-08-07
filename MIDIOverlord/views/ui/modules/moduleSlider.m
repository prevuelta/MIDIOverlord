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
    
    
    // Add Slider
    _slider = [[controlSlider alloc] initWithSize:NSMakeSize(self.width, 16) andValue: data[@"ccValue"] andMinValue: 0 andMaxValue:127 ];
    
    [_slider setOrigin:NSMakePoint(0, 0)];
    
    [self bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];

    // Add Label
    uiEditableTextField *editLabel = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 7];
    [editLabel setOrigin:NSMakePoint(18, 16)];
    
    [_data bind:@"label" toObject: editLabel withKeyPath:@"savedString" options:nil];
    
    [self addSubview:editLabel];

    _ccControl = [[controlText alloc] initWithLabel: @"CC" andValue: data[@"ccNumber"]];
    
   [_ccControl setOrigin:NSMakePoint(editLabel.frameWidth + 34, 16)];
    
   [_data bind:@"ccNumber" toObject: _ccControl withKeyPath:@"value" options:nil];
    
   [self addSubview: _ccControl ];

    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(self.width - 18, 18)];

    [self addSubview: removeBtn];

    uiButton *inputRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"midireceiveRecord"];
    [inputRecord setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [inputRecord setIsToggle: YES];
    [inputRecord setOrigin: NSMakePoint(0, 16)];
    
    uiButton *outputRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"midiSendRecord"];
    [outputRecord setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [outputRecord setIsToggle: YES];
    [outputRecord setOrigin: NSMakePoint(18, 16)];

    [self addSubview: inputRecord];
    [self addSubview: outputRecord];
    
    return self;
}

-(NSNumber*)ccValue {
    return _ccValue;
}

-(void)setCcValue:(NSNumber*)ccValue {
    NSLog(@"Changing...");
    _ccValue = ccValue;
    if(![self.data[@"ccNumber"] isEqualToNumber:@-1]) {
        [self.delegate midiCommand: @[self.data[@"ccStatus"], self.data[@"ccNumber"], self.data[@"ccValue"]]];
    }
}


@end

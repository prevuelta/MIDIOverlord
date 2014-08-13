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
    
    self.MIDIIdentifier = data[@"moduleID"];
    
    // Add Slider
    _slider = [[controlSlider alloc] initWithSize:NSMakeSize(self.width, 16) andValue: data[@"ccValue"] andMinValue: 0 andMaxValue:127 ];
    
    [_slider setOrigin:NSMakePoint(0, 0)];
    
    [self bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];

    // Add Label
    self.label = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 7];
    [self.label setOrigin:NSMakePoint(0, 16)];
    
    [_data bind:@"label" toObject: self.label withKeyPath:@"savedString" options:nil];
    
    [self addSubview: self.label];
    
    /* Setup input */

    uiButton *inputRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"receiveRecord"];
    [inputRecord setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [inputRecord setIsToggle: YES];
    [inputRecord setOrigin: NSMakePoint(self.label.frameWidth + 2, 16)];
    
    [self addSubview: inputRecord];
    
//    controlText *receiveCC = [[controlText alloc] initWithLabel: @"CC" andValue: data[@"receiveCC"]];
//   [receiveCC setOrigin:NSMakePoint(self.label.frameWidth + 18, 16)];
//   [_data bind:@"receiveCC" toObject: receiveCC withKeyPath:@"value" options:nil];
//    
//   [self addSubview: receiveCC ];
    
    controlText *sendCC = [[controlText alloc] initWithLabel: @"CC" andValue: data[@"sendCC"]];
    [sendCC setOrigin:NSMakePoint(self.label.frameWidth + 18, 16)];
    [_data bind:@"sendCC" toObject: sendCC withKeyPath:@"value" options:nil];
    
    [self addSubview: sendCC ];
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(self.width - 18, 18)];

    [self addSubview: removeBtn];

    uiButton *outputRecord = [[uiButton alloc] initWithSize: 16 andEvent: @"sendRecord"];
    [outputRecord setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [outputRecord setIsToggle: YES];
    [outputRecord setOrigin: NSMakePoint(self.label.frameWidth + 20, 16)];

    
    [self addSubview: outputRecord];
    
    return self;
}

-(NSNumber*)ccValue {
    return _ccValue;
}

-(void)setCcValue:(NSNumber*)ccValue {
    NSLog(@"Changing...");
    _ccValue = ccValue;
    if(![self.data[@"sendCC"] isEqualToNumber:@-1]) {
        [self.delegate midiCommand: @[self.data[@"ccStatus"], self.data[@"sendCC"], self.data[@"ccValue"]]];
    }
}


@end

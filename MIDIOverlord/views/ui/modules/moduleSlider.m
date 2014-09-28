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
    
    int height = 36;
    
    self = [super initWithHeight: height];
    
    if(!self) return nil;
    
    _ccValue = 0;
    
    _data = data;
    
    self.MIDIIdentifier = data[@"moduleID"];
    
    // Add Slider
    _slider = [[controlSlider alloc] initWithSize:NSMakeSize(self.width - 8, 18) andValue: data[@"ccValue"] andMinValue: 0 andMaxValue:127 ];
    
    [_slider setOrigin:NSMakePoint(2, 2)];
    
    [self bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];

    int controlY = 0;
    
    // Add Label
    self.label = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 7];
    [self.label setOrigin:NSMakePoint(0, 20)];
    
    [_data bind:@"label" toObject: self.label withKeyPath:@"savedString" options:nil];
    
    [self addSubview: self.label];
    
    controlY += self.label.frameWidth + 2;
    
    /* Setup input */

    uiButton *inputRecord = [[uiButton alloc] initWithSize: 12 andEvent: @"receiveRecord"];
    [inputRecord setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [inputRecord setIsToggle: YES];
    [inputRecord setOrigin: NSMakePoint(controlY, 22)];
    
    [self addSubview: inputRecord];
    
    controlY += inputRecord.frameWidth + 2;
    
    controlText *receiveCC = [[controlText alloc] initWithLabel: @"IN" andValue: data[@"receiveCC"]];
   [receiveCC setOrigin:NSMakePoint(controlY, 20)];
   [_data bind:@"receiveCC" toObject: receiveCC withKeyPath:@"value" options:nil];
    
   [self addSubview: receiveCC ];
    
    /* Setup output */
    
    controlY += receiveCC.frameWidth + 2;
    
    uiButton *outputRecord = [[uiButton alloc] initWithSize: 12 andEvent: @"sendRecord"];
    [outputRecord setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [outputRecord setIsToggle: YES];
    [outputRecord setOrigin: NSMakePoint(controlY, 22)];
    
    [self addSubview: outputRecord];
    
    controlY += outputRecord.frameWidth + 2;
    
    controlText *sendCC = [[controlText alloc] initWithLabel: @"OU" andValue: data[@"sendCC"]];
    [sendCC setOrigin:NSMakePoint(controlY, 20)];
    [_data bind:@"sendCC" toObject: sendCC withKeyPath:@"value" options:nil];
    
    [self addSubview: sendCC ];
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(self.width - 18, 22)];

    [self addSubview: removeBtn];
    
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

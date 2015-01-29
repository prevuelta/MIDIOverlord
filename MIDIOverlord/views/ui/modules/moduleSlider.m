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
    
    int height = 56;
    
    self = [super initWithHeight: height];
    
    if(!self) return nil;
    
    _ccValue = 0;
    
    self.unitSize = 1;
    
    _data = data;
    
    self.MIDIIdentifier = data[@"moduleID"];
    
    // Add Slider
//    _slider = [[controlSlider alloc] initWithSize:NSMakeSize(self.width - 8, 18) andValue: data[@"ccValue"] andMinValue: 0 andMaxValue:127 ];
//    
//    [_slider setOrigin:NSMakePoint(2, 2)];
//    
//    [self bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
//    [_data bind:@"ccValue" toObject:_slider withKeyPath:@"value" options:nil];
//    
//    [self addSubview: _slider];

    // Add dial
    
    _dial = [[controlDial alloc] initWithSize: 40 andValue: data[@"ccValue"] ];
    [_dial setOriginWithX: 42 andY: 0];
    [self addSubview: _dial];
    
    [self bind:@"ccValue" toObject:_dial withKeyPath:@"value" options:nil];
    [_data bind:@"ccValue" toObject:_dial withKeyPath:@"value" options:nil];
    
    int controlY = 0;
    
    // Add Label
    self.label = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 9];
    [self.label setOrigin:NSMakePoint(0, 42)];
    
    [_data bind:@"label" toObject: self.label withKeyPath:@"savedString" options:nil];
    
    [self addSubview: self.label];
    
    controlY += self.label.frameWidth + 2;
    
    /* Setup input */

    controlText *receiveCC = [[controlText alloc] initWithLabel: @"IN" andValue: data[@"receiveCC"]];
   [receiveCC setOrigin:NSMakePoint(0, 28)];
   [_data bind:@"receiveCC" toObject: receiveCC withKeyPath:@"value" options:nil];
    
   [self addSubview: receiveCC ];
    
    /* Setup output */
    
    controlText *sendCC = [[controlText alloc] initWithLabel: @"OU" andValue: data[@"sendCC"]];
    [sendCC setOrigin:NSMakePoint(0, 14)];
    [_data bind:@"sendCC" toObject: sendCC withKeyPath:@"value" options:nil];
    
    [self addSubview: sendCC ];
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(82 - 12, 42)];

    [self addSubview: removeBtn];
    
//    uiToggle *toggleRelative = [[uiToggle alloc]];
    
    _valueField = [[uiTextField alloc] initWithString: [_data[@"ccValue"] stringValue] andMaxLength:3];
    [_valueField setOriginWithX: 16];
    
    [self addSubview: _valueField];
    
    return self;
}

-(NSNumber*)ccValue {
    return _ccValue;
}

-(void)setCcValue:(NSNumber*)ccValue {
    _ccValue = ccValue;
    [_valueField setStringValue: [self.ccValue stringValue]];
    if(![self.data[@"sendCC"] isEqualToNumber:@-1]) {
        [self.delegate midiCommand: @[self.data[@"ccStatus"], self.data[@"sendCC"], self.data[@"ccValue"]]];
    }
}


@end

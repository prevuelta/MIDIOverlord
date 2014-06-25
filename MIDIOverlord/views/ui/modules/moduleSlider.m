//
//  moduleSlider.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleSlider.h"

@implementation moduleSlider

@synthesize midiV3 = _midiV3;
@synthesize data = _data;

-(id)initWithData:(NSMutableDictionary*)data{
    
    self.value = 0;
    self.height = 40;

    self = [super initWithFrame:NSMakeRect(0, 0, RACK_WIDTH - SCROLLER_WIDTH, self.height)];
    
    if(!self) return nil;
    
    self.midiV1 = @176;
    self.midiV2 = @0;
    self.midiV3 = @0;
    
    NSLog(@"Init with data");
    
    controlText *midiV2Control = [[controlText alloc] initWithString: @"CC000"];
    
    [midiV2Control setOrigin:NSMakePoint(2, 2)];
    
    [midiV2Control setInEditView:YES];
    
    [midiV2Control setMax:127];
    
    [self addSubview: midiV2Control];
    
    // Add UI buttons
    
    _slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width, 20): NSMakePoint(0, 0): 0 :127 ];
    
    [_slider setOrigin:NSMakePoint(0, 1)];

    [self bind:@"midiV3" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];
    
    [self addCCField];

    [self setData: data];
    
    uiEditText *label = [[uiEditText alloc] initWithString: @"Resonance" andMaxLength: 6 andLabelLength: 0];
    
    [label setOrigin:NSMakePoint(2, 22)];
    
    [self bind:@"labelText" toObject:label withKeyPath:@"stringValue" options:nil];
    
    [self addSubview:label];
    
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

-(NSNumber*)midiV3 {
    return _midiV3;
}

-(void)setMidiV3:(NSNumber*)midiV3 {
    _midiV3 = midiV3;
    [self.delegate midiData: @[self.midiV1, self.midiV2, self.midiV3]];
    [self.data setObject:_midiV3 forKey:@"value"];
    [self updateModel];
}



-(NSMutableDictionary*)data {
    return _data;
}

-(void)setData:(NSMutableDictionary*)data {
//    NSLog(@"Data: %@", data);
    [_slider updateControlFromData: data[@"value"]];
    _data = data;
}

@end

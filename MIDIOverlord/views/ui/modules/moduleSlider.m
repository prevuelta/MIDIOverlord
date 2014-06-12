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

-(id)initWithFrame{
    
    self.value = 0;
    self.height = 18;

    self = [super initWithFrame:NSMakeRect(0, 0, RACK_WIDTH, self.height)];
    
    if(!self) return nil;
    
    self.midiV1 = @176;
    self.midiV2 = @0;
    self.midiV3 = @0;
    
    // controlText *midiValueText = [[controlText alloc] initWithFrame: self.midiV2 andLabel: @"CC" andMaxVal:127];
        
    // [midiValueText setOrigin:NSMakePoint(0, 12)];
        
    // midiValueText setEditable:YES];
    
    // Add UI buttons
    
    // Add UI buttons
    
    _slider = [[controlSlider alloc] initWithFrame:NSMakePoint(self.width, 16): NSMakePoint(0, 0): 0 :127 ];
    
    [_slider setOrigin:NSMakePoint(0, 0)];

    [self bind:@"midiV3" toObject:_slider withKeyPath:@"value" options:nil];
    
    [self addSubview: _slider];
    
    [self addCCField];
    
    return self;
}

-(void)drawModule:(NSRect)rect {
    // NSLog(@"Slide val: %@", [NSNumber numberWithInt:self.midiV2]);
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
    NSLog(@"Data: %@", data);
    [_slider updateControlFromData: data[@"value"]];
    _data = data;
}

//-(void)setData:(NSMutableDictionary*)data {
////    [_slider setValue: data[@"value"]];
//    NSLog(@"Data: %@", data);
//    self.data = data;
//}

@end

//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePads.h"

@implementation modulePads

@synthesize data = _data;
@synthesize delegate = _delegate;

-(id)initWithData: (NSMutableDictionary*)data {
    
    self = [super initWithUnitWidth: data[@"unitWidth"] andUnitHeight: data[@"unitHeight"]];
    
    if(!self) return nil;
    
    
    self.data = data;
    
    _pads = [NSMutableArray new];
    
    [self setFlipped: YES];
    
    int padCount = 0;
    
    uiEditableTextField *label = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 8];
    [label setOriginWithX: 0 andY: 0];
    [self addSubview: label];
    
    [_data bind:@"label" toObject: label withKeyPath:@"savedString" options:nil];
    
    for(NSMutableDictionary *padData in self.data[@"pads"]) {
        
//        NSLog(@"Pad data: %@", padData);
        
        modulePad *pad = [[modulePad alloc] initWithData: padData];
        
        [pad setDelegate: self.superview];
        
        [NSApp registerMIDIResponder: pad];
        
//        NSLog(@"Unique ident %@", pad.MIDIIdentifier);
        
//        NSLog(@"Padcount: %i", padCount % 2);
        NSLog(@"Padunitsize:%d", pad.unitWidth);
//        0, 1, 0, 1
        [pad setOriginWithX: (padCount % 2 ? [self getWidth] :  0) andY: padCount > 1 ? [self getHeight] + 14 : 14];
        [self addSubview: pad];
        [_pads addObject: pad];
        padCount++;
    }
    

    uiButton *removeBtn = [[uiButton alloc] initWithSize: 16 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint([self getWidth] - 16, 0)];
    
    [self addSubview: removeBtn];

    return self;
    
}



-(void)setDelegate:(id)delegate {
    for(modulePad *pad in self.pads) {
        [pad setDelegate: delegate];
    }
    _delegate = delegate;
}


@end

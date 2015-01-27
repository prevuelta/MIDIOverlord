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
    
    int height = 90;
    
    self = [super initWithHeight: height];
    
    if(!self) return nil;
    
    NSLog(@"Width: %d", self.width);
    
    self.data = data;
    
    _pads = [NSMutableArray new];
    
    [self setFlipped: YES];
    
    int padCount = 0;
    
    uiEditableTextField *label = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 8];
    [label setOriginWithX: 0 andY: 0];
    [self addSubview: label];
    
    [_data bind:@"label" toObject: label withKeyPath:@"savedString" options:nil];
    
    for(NSMutableDictionary *padData in self.data[@"pads"]) {
        
        NSLog(@"Pad data: %@", padData);
        
        modulePad *pad = [[modulePad alloc] initWithData: padData];
        
        [pad setDelegate: self.superview];
        
        [NSApp registerMIDIResponder: pad];
        
        NSLog(@"Unique ident %@", pad.MIDIIdentifier);
        
        NSLog(@"Padcount: %i", padCount % 2);
//        0, 1, 0, 1
        [pad setOriginWithX: (padCount % 2 ? MODULE_WIDTH / 2 :  0) andY: padCount > 1 ? pad.frameHeight + 18 : 18];
        [self addSubview: pad];
        [_pads addObject: pad];
        padCount++;
    }
    

    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(MODULE_WIDTH - 14, 2)];
    [removeBtn setInEditView:YES];
    
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

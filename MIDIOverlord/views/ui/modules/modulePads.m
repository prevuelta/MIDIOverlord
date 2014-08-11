//
//  modulePad.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePads.h"

@implementation modulePads

@synthesize currentNote = _currentNote;

@synthesize data = _data;

@synthesize pad1Active = _pad1Active;
@synthesize pad2Active = _pad2Active;
@synthesize pad3Active = _pad3Active;;
@synthesize pad4Active = _pad4Active;

-(id)initWithData: (NSMutableDictionary*)data{
    
    int height = 90;
    
    self = [super initWithHeight: height];
    
    if(!self) return nil;
    
    NSLog(@"Width: %d", self.width);
    
    self.data = data;
    
    [self setFlipped: YES];
    
    int padCount = 0;
    
    uiEditableTextField *label = [[uiEditableTextField alloc] initWithString: _data[@"label"] andMaxLength: 8];
    [label setOriginWithX: 0 andY: 0];
    [self addSubview: label];
    
    [_data bind:@"label" toObject: label withKeyPath:@"savedString" options:nil];
    
    for(NSMutableDictionary *padData in self.data[@"pads"]) {
        NSLog(@"Pad data: %@", padData);
        modulePad *pad = [[modulePad alloc] initWithData: padData];
        NSLog(@"Padcount: %i", padCount % 2);
//        0, 1, 0, 1
        [pad setOriginWithX: (padCount % 2 ? MODULE_WIDTH / 2 :  0) andY: padCount > 1 ? pad.frameHeight + 18 : 18];
        [self addSubview: pad];
        padCount++;
    }
    
//    NSMutableArray *padObj = [NSMutableArray new];
    
//    for(int i = 0; i < padCount; i++) {
//        NSString *noteStr = [NSString stringWithFormat: @"pad%dNote", i+1];
//        NSString *velStr = [NSString stringWithFormat: @"pad%dVel", i+1];
//        NSString *activeStr = [NSString stringWithFormat: @"pad%dActive", i+1];
//        [padObj addObject: [[controlPad alloc] initWithSize: padSize andNoteValue: self.data[noteStr] andVelocity: self.data[velStr]]];
//        [self.data bind: noteStr toObject: padObj[i] withKeyPath: @"noteValue" options: nil];
//        [self.data bind: velStr toObject: padObj[i] withKeyPath: @"velocity" options: nil];
//        [self bind: activeStr toObject: padObj[i] withKeyPath: @"active" options: nil];
//        [padObj[i] setOrigin:NSMakePoint(padPos, 0)];
//        [self addSubview: padObj[i]];
//        padPos += padSize.y + 2;
//    }

    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"removeModule"];
    [removeBtn setEventData: @{@"rackID": self.data[@"rackID"], @"moduleID" : self.data[@"moduleID"]}];
    [removeBtn setOrigin: NSMakePoint(MODULE_WIDTH - 14, 2)];
    [removeBtn setInEditView:YES];
    
    [self addSubview: removeBtn];

    return self;
    
}

-(NSNumber*)currentNote {
    return _currentNote;
}

-(void)setCurrentNote:(NSNumber*)currentNote {
    _currentNote = currentNote;
}
//
//-(BOOL)pad1Active {
//    return _pad1Active;
//}
//-(BOOL)pad2Active {
//    return _pad2Active;
//}
//-(BOOL)pad3Active {
//    return _pad3Active;
//}
//-(BOOL)pad4Active {
//    return _pad4Active;
//}

//-(void)setPad1Active:(BOOL)pad1Active {
//    NSLog(@"Sending note %@", _data[@"pad1Note"]);
//    _pad1Active = pad1Active;
//    if([_data[@"pad1Note"] intValue] >= 0)
//        [self.delegate midiCommand: @[pad1Active ? _data[@"noteOnStatus"] : _data[@"noteOffStatus"], _data[@"pad1Note"], _data[@"pad1Vel"]]];
//}
//-(void)setPad2Active:(BOOL)pad2Active {
//    _pad2Active = pad2Active;
//    if([_data[@"pad2Note"] intValue] >= 0)
//        [self.delegate midiCommand: @[pad2Active ? _data[@"noteOnStatus"] : _data[@"noteOffStatus"], _data[@"pad2Note"], _data[@"pad2Vel"]]];
//}
//
//-(void)setPad3Active:(BOOL)pad3Active {
//    _pad3Active = pad3Active;
//    if([_data[@"pad3Note"] intValue] >= 0)
//        [self.delegate midiCommand: @[pad3Active ? _data[@"noteOnStatus"] : _data[@"noteOffStatus"], _data[@"pad3Note"], _data[@"pad3Vel"]]];
//}
//
//-(void)setPad4Active:(BOOL)pad4Active {
//    _pad4Active = pad4Active;
//    if([_data[@"pad4Note"] intValue] >= 0)
//        [self.delegate midiCommand: @[pad4Active ? _data[@"noteOnStatus"] : _data[@"noteOffStatus"], _data[@"pad4Note"], _data[@"pad4Vel"]]];
//}



@end
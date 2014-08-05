//
//  modulePad.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "modulePad.h"

@interface modulePads : moduleBase

@property NSNumber *currentNote;

@property BOOL pad1Active;
@property BOOL pad2Active;
@property BOOL pad3Active;
@property BOOL pad4Active;

-(NSString*)noteString:(int)noteNum;


@end

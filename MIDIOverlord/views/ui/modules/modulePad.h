//
//  modulePad.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@interface modulePad : moduleBase

@property NSNumber *currentNote;

-(id)initWithData:(NSMutableDictionary*)data;
-(NSString*)noteString:(int)noteNum;

@end

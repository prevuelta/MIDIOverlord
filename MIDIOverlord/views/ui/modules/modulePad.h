//
//  modulePad.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@interface modulePad : moduleBase

@property BOOL velocityIsLocked;

@property int min;
@property int max;
@property int range;
@property NSNumber *velocity;

//@property NSNumber *inputValue;

//@property NSNumber *noteValue;
//@property NSString *noteString;

@end

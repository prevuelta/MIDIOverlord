//
//  modulePad.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@interface modulePad : moduleBase <MIKMIDIResponder>

@property BOOL velocityIsLocked;

@property int min;
@property int max;
@property int range;
@property NSNumber *velocity;

@property controlText *receiveValue;
@property controlSlider *velocitySlider;

@end

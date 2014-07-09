//
//  moduleSlider.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@interface moduleSlider : moduleBase

@property NSNumber* ccValue;
@property controlSlider *slider;
@property controlText *ccControl;


-(id)initWithData:(NSMutableDictionary*)data;

@end

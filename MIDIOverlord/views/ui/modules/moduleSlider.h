//
//  moduleSlider.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@interface moduleSlider : moduleBase

-(id)initWithFrame;

@property int value;
@property controlSlider *slider;
@property controlText *ccControl;

//-(void)setData:(NSMutableDictionary*)data;
-(id)initWithData:(NSMutableDictionary*)data;

@end

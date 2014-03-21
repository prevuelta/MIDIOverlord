//
//  controlDeviceList.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "controlSwitch.h"

@interface controlDeviceList : controlBase

-(id)initWithFrame:(NSRect)frame :(NSMutableArray*)devices;

@end

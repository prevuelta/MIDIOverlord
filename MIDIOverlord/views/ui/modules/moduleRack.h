//
//  rack.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@interface moduleRack : moduleBase

@property NSDictionary* data;

@property NSMutableArray* subViews;

-(void)addRackTitle;

@property int headerWidth;

@end

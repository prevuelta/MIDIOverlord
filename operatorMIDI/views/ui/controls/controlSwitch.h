//
//  controlSwitch.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@interface controlSwitch : controlBase

@property bool on;

-(id)initWithFrame:(NSRect)frame :(char)label;
-(void)drawRect:(NSRect)rect;
-(void)setLabel:(NSString*)text;

@end

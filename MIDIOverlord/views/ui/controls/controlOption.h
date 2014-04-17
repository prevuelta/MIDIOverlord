//
//  controlOption.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "uiLabel.h"

@interface controlOption : controlBase;

@property uiLabel *label;

-(void)setStringValue:(NSString*)str;

@end

//
//  controlUI.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface controlUI : NSView

@property NSArray* channelIN;
@property NSArray* channelOUT;
@property int val;
@property int max;
@property int min;
@property NSString* label;

@end

//
//  controlBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "utilities.h"
#import "uiTextField.h"
#import "global.h"
#import "uiButton.h"

@interface controlBase : uiBase

@property NSColor *defaultColor;
@property NSColor *activeColor;
@property NSColor *toggleColor;
@property NSColor *disabledColor;

@end

//
//  gmSlider.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 2/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface controlSlider : NSView

@property NSSlider *slider;

- (id)initWithFrame:(NSRect)frame;
- (void)drawRect:(NSRect)frame;

@end;

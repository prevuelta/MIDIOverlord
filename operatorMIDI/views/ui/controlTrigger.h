//
//  gmUIElement.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "controlBase.h"

@interface controlTrigger : controlBase

@property NSColor* bg;
@property NSPoint size;
@property NSPoint offset;

- (id)initWithFrame:(NSPoint)size :(NSPoint)offset :(NSColor*)bg;

@end

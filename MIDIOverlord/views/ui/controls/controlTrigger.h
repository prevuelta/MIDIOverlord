//
//  gmUIElement.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "controlBase.h"
#import "controlText.h"

@interface controlTrigger : controlBase

@property NSColor* upColor;
@property NSColor* downColor;
@property NSPoint size;

- (id)initWithSize:(NSPoint)size;

@end

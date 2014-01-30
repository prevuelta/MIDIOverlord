//
//  gmUIElement.h
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uiButton : NSView

@property NSBezierPath* path;
@property NSColor* bg;
@property int size;
@property NSPoint offset;

- (id)initWithFrame:(NSRect)frame :(int)size :(NSPoint)offset;
- (void)drawBox;

@end

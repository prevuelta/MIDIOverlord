//
//  grid.h
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Grid : NSView {


}

@property int XDivisions;
@property int YDivisions;

- (id)initWithFrame:(NSRect)frame;
- (void)drawRect:(NSRect)frame;

- (void)setItemColor:(NSColor *)aColor;
- (NSColor *)itemColor;

@end
//
//  controlClass.h
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface controlClass : NSView

@property NSDictionary* elData;
// Canvas properties

@property int padding;
@property int cWidth;
@property int gridX;
@property int gridY;


- (id)initWithFrame:(NSRect)frame;
- (void)setOrigin:(NSPoint)origin;
-(void)mouseDown:(NSEvent *)theEvent;

@end

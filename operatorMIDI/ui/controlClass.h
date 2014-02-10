//
//  controlClass.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "uiButton.h"

@interface controlClass : NSView {
//    @p
}

@property NSDictionary* elData;
// Canvas properties

@property int padding;
@property int width;
@property int gridX;
@property int gridY;

- (id)initWithFrame:(NSRect)frame;
- (void)setOrigin:(NSPoint)origin;
-(void)mouseDown:(NSEvent *)theEvent;

@end

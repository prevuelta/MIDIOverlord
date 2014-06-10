//
//  controlBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "utilities.h"

@interface controlBase : NSView

@property BOOL active;
@property BOOL selected;

@property NSInteger tag;

@property NSColor *blackColor;
@property NSColor *defaultColor;
@property NSColor *markerColor;
@property NSColor *activeColor;

-(void)deselect:(NSNotification*)notification;

-(void)setDefaults;
-(void)drawRect:(NSRect)rect;

-(void)setOrigin:(NSPoint)origin;

- (void)mouseEntered:(NSEvent *)theEvent;

@end

//
//  controlBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "uiLabel.h"
#import "utilities.h"

@class controlBase;

@protocol controlBaseDelegate
    -(void)uiEvent:(char*)type;
    -(void)uiEvent:(char*)type withInt:(int)val;
@end

@interface controlBase : NSView

@property (nonatomic, assign) id delegate;

@property BOOL active;
@property BOOL selected;

@property NSInteger tag;

@property NSColor *defaultColor;
@property NSColor *markerColor;
@property NSColor *activeColor;

-(void)deselect:(NSNotification*)notification;

-(void)setDefaults;
-(void)drawRect:(NSRect)rect;
-(void)uiEvent:(char*)type;
-(void)uiEvent:(char*)type withInt:(int)val;

-(void)setOrigin:(NSPoint)origin;

- (void)mouseEntered:(NSEvent *)theEvent;

@end

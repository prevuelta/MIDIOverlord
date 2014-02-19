//
//  gmUIElement.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@class uiButton;

@protocol uiButtonDelegate
    -(void)handleTrigger:(uiButton *)uiButton;
@end

@interface uiButton : NSView

@property (nonatomic, assign) id delegate;

@property NSBezierPath* path;
@property NSColor* bg;
@property NSPoint size;
@property NSPoint offset;

- (id)initWithFrame:(NSPoint)size :(NSPoint)offset :(NSColor*)bg;
- (void)drawRect:(NSRect)rect;

@end

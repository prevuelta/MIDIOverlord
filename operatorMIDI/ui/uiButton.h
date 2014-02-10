//
//  gmUIElement.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uiButton : NSView {
//    id<subViewDelegate> delegate;
}

//@property (nonatomic, assign) id<subViewDelegate> delegate;

@property NSBezierPath* path;
@property NSColor* bg;
@property NSPoint size;
@property NSPoint offset;

- (id)initWithFrame:(NSRect)frame :(NSPoint)size :(NSPoint)offset;
- (void)drawRect:(NSRect)rect;

@end

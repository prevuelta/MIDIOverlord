//
//  uiApp.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface uiApp : NSView

- (id)initWithFrame:(NSRect)frame;
-(void)drawRect:(NSRect)dirtyRect;
-(void)setOrigin:(NSPoint)origin;

@end

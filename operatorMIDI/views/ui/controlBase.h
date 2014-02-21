//
//  controlBase.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class controlBase;

@protocol controlBaseDelegate
    -(void)uiEvent:(char*)type;
@end

@interface controlBase : NSView

@property (nonatomic, assign) id delegate;

-(void)drawRect:(NSRect)rect;
-(void)uiEvent:(char*)type;

@end

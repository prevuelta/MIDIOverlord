//
//  controlBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "utilities.h"
#import "uiText.h"

@interface controlBase : uiBase

@property NSInteger tag;
@property BOOL inEditView;

-(void)drawRect:(NSRect)rect;

-(void)mouseEntered:(NSEvent *)theEvent;


@end

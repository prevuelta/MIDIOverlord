//
//  uiApp.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 10/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "uiText.h"
#import "uiButton.h"

@interface uiApp : uiBase

- (id)initWithFrame:(NSRect)frame;
-(void)drawRect:(NSRect)dirtyRect;

@end

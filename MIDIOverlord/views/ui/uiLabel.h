//
//  uiLabel.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 24/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface uiLabel : NSTextField

-(id)initWithFrame:(NSRect)frameRect;

-(void)drawRect:(NSRect)rect;

@end

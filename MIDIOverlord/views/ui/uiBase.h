//
//  uiBase.h
//  MIDIOverlord
//
//  Created by Pablo on 10/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import <MIKMIDI/MIKMIDI.h>
#import "MIKMIDIDeviceManagerInterface.h"
#import "global.h"
#import "utilities.h"

@interface uiBase : NSView

// States
@property BOOL active;
@property BOOL selected;
@property BOOL disabled;
@property BOOL inEditView;
@property BOOL flipped;

-(id)initWithFrame:(NSRect)frame;

-(void)setOriginWithX: (int)x;
-(void)setOriginWithX: (int)x andY: (int)y;
-(void)setOrigin:(NSPoint)origin;

-(void)drawRect:(NSRect)dirtyRect;

-(void)deselect:(NSNotification*)notification;

-(void)resizeHeight:(int)newHeight;
-(void)resizeWidth:(int)newWidth;

-(float)frameHeight;
-(float)frameWidth;
-(float)originY;

@end

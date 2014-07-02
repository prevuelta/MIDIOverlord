//
//  uiButton.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/05/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "uiBase.h"

@interface uiButton : uiBase

@property int width;
@property int height;

@property NSPoint iconOrigin;

@property BOOL isToggle;
@property BOOL toggled;

@property NSString *event;
@property NSDictionary* eventData;

@property NSImageView *iconView;

-(id)initWithSize:(int)size;
-(id)initWithSize:(int)size andEvent:(NSString*)event;

-(void)setEvent:(NSString*)event withData:(NSDictionary*)data;
-(void)setIconViewOrigin:(NSPoint)origin;

@end

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

@property BOOL isToggle;
@property BOOL toggled;

@property NSString *event;
@property NSDictionary* eventData;

@property NSMutableArray *icon;

-(id)initWithFrame:(int)size;

-(void)setEvent:(NSString*)event withData:(NSDictionary*)data;
-(void)setOnEvent:(NSString*)event;
-(void)setOffEvent:(NSString*)event;

@end

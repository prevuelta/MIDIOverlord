//
//  uiButton.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/05/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface uiButton : NSView

@property int width;
@property int height;

@property BOOL active;

@property NSColor *defaultColor;
@property NSColor *markerColor;
@property NSColor *activeColor;

@property NSString *event;
@property NSDictionary* eventData;

-(void)setOrigin:(NSPoint)origin;
-(id)initWithFrame:(int)size;
-(void)setEvent:(NSString*)event withData:(NSDictionary*)data;

@end

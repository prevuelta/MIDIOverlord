//
//  gmUIElement.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "controlBase.h"
#import "controlText.h"

@class controlPad;

@protocol moduleBaseDelegates
-(void)midiCommand:(NSArray*)data;
@end

@interface controlPad : controlBase

@property (nonatomic, assign) id delegate;



@property NSNumber* noteValue;
@property NSNumber* velocity;
@property int max;
@property int min;
@property int range;

@property int marker;

@property NSString* noteName;
@property NSPoint size;

@property controlText *padNote;
@property uiTextField* noteLabel;
@property uiTextField* velocityLabel;

@property NSColor *defaultColor;
@property NSColor *activeColor;
@property NSColor *markerColor;

-(id)initWithSize:(NSPoint)size andNoteValue: (NSNumber*)noteValue andVelocity: (NSNumber *)velocity;

@end

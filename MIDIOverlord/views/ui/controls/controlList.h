//
//  controlList.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "controlOption.h"

@interface controlList : controlBase

@property int width;

@property int activeOption;
@property int optionCount;
@property NSMutableArray *optionData;
@property int height;
@property BOOL state;
@property NSColor* bgColor;
@property NSColor* activeBgColor;
@property NSColor* fgColor;

-(id)initWithFrame: (NSMutableArray*)keyValues andLabel:(NSString*)labelText;
-(void)deselect:(NSNotification*)notification;
-(void)showHideOptions;
-(void)updateValues;

@end

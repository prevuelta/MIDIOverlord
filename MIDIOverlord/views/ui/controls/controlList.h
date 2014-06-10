//
//  controlList.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "controlOption.h"

@interface controlList : controlBase <controlOptionDelegate>

@property int width;

@property int activeOption;
@property NSInteger optionCount;
@property NSMutableArray *optionData;
@property int height;
@property BOOL state;
@property NSColor* bgColor;
@property NSColor* activeBgColor;
@property NSColor* fgColor;
@property NSString *labelText;

@property uiText *selectedLabel;

@property int selectedValue;

-(id)initWithFrame: (NSString*)labelText;
-(void)deselect:(NSNotification*)notification;

-(void)addOptions:(NSArray*)keyValues;

-(void)updateValues;

-(void)setSelectedlabel:(NSString*)selectedLabel;

@end

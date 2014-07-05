//
//  controlOption.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "uiText.h"

@class controlOption;

@protocol controlOptionDelegate
-(void)optionSelectedWithKeyValue: (NSArray*)keyValue;
@end

@interface controlOption : controlBase;

@property (nonatomic, assign) id delegate;

@property NSArray* keyValue;
@property uiText *label;

- (id)initWithKeyValue: (NSArray*)keyValue;

@end

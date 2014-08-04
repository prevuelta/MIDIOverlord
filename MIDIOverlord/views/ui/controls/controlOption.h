//
//  controlOption.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"
#import "uiTextField.h"

@class controlOption;

@protocol controlOptionDelegate
//-(void)setSelectedIndex: (int)index;
@end

@interface controlOption : controlBase;

@property (nonatomic, assign) id delegate;

@property uiTextField *label;
@property int index;

- (id)initWithName: (NSString*)name andIndex:(int)index;

@end

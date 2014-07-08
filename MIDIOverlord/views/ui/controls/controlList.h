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

@property NSMutableDictionary *options;
@property int optionCount;

@property NSArray *selectedOption;

@property int height;
//@property BOOL state;

@property NSString *labelText;

@property uiTextField *label;

-(id)initWithOptions:(NSMutableDictionary*)options andOptionCount: (int)optionCount;
-(void)deselect:(NSNotification*)notification;

@end

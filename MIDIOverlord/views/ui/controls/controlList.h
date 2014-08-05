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

@property int height;
@property int width;

@property NSArray *content;
@property NSNumber* selectedIndex;

@property id selectedObject;

@property NSInteger tag;

@property NSString *labelText;

@property uiTextField *label;

-(id)initWithContent:(NSArray*)content;

-(void)deselect:(NSNotification*)notification;


@end

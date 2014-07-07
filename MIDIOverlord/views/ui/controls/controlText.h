//
//  controlText.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiEditText.h"
#import "controlBase.h"

@interface controlText : controlBase;

@property uiEditText *label;
@property NSString* stringValue;

@property int min;
@property int max;
@property NSNumber *value;

@property NSString* stringLabel;

- (id)initWithLabel: (NSString*)stringLabel;
-(NSString*)labelPlusValue;

@end

//
//  controlText.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiText.h"
#import "controlBase.h"

@interface controlText : controlBase;

@property uiText *label;
@property NSString* stringValue;

-(id)initWithString: (NSString*)stringValue;

@end

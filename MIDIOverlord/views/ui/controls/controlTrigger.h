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

@class controlTrigger;

@protocol moduleBaseDelegates
-(void)midiCommand:(NSArray*)data;
@end

@interface controlTrigger : controlBase

@property (nonatomic, assign) id delegate;

@property NSNumber* value;
@property int min;
@property int max;

@property NSSize size;

-(id)initWithSize:(NSSize)size andValue: (NSNumber *)value;

@end

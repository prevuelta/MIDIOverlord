//
//  uiIndicator.h
//  MIDIOverlord
//
//  Created by Pablo on 7/02/2015.
//  Copyright (c) 2015 Midnight City. All rights reserved.
//

#import "controlBase.h"

@interface uiIndicator : controlBase

@property int type;

-(id)init;
-(void)ping;
-(void)fade;

@end

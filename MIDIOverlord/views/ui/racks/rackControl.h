//
//  rackControl.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 29/05/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "rackBase.h"
#import "uiButton.h"

@interface rackControl : rackBase

-(void)startListening;
-(void)stopListening;

-(void)startRecording:(NSString*)MIDIIdentifier;

@end

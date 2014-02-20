//
//  eventHandler.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 31/01/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "eventHandler.h"

@implementation eventHandler

// Posts a MyNotification message whenever called
- (id)init {
    if (!self) return nil;
        NSLog(@"Event handler init");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiNotification:) name:@"midiNote" object:nil];
    
    return self;
}

// Prints a message whenever a MyNotification is received
- (void)midiNotification:(NSNotification*)notification {
    NSLog(@"Got notified: %@", notification);
    if(notification.name == @"midiNote") {
        [_delegate sendNote:124];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"Observer removed");
}

@end

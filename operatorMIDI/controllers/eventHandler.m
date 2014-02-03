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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"controlChange" object:nil];
    
    return self;
}

// Prints a message whenever a MyNotification is received
- (void)handleNotification:(NSNotification*)notification {
    NSLog(@"Got notified: %@", notification);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"Observer removed");
    // [super dealloc]; <<== Compiler inserts this for you
}

@end

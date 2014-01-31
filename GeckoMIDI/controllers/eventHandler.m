//
//  eventHandler.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 31/01/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "eventHandler.h"

@implementation eventHandler

// Posts a MyNotification message whenever called
- (void)init {
    NSLog(@"Event handler init");
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"MyNotification" object:nil];
    
}

// Prints a message whenever a MyNotification is received
- (void)handleNotification:(NSNotification*)note {
    NSLog(@"Got notified: %@", note);
}

- (void)dealloc {
//    [_center removeObserver:self];
    NSLog(@"Observer removed");
    // [super dealloc]; <<== Compiler inserts this for you
}

@end

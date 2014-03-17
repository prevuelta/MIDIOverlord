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
//- (id)init {
//    if (!self) return nil;
//        NSLog(@"Event handler init");
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiNotification:) name:@"noteOn" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiNotification:) name:@"noteOff" object:nil];
//    
//    return self;
//}
//
//// Prints a message whenever a MyNotification is received
//- (void)midiNotification:(NSNotification*)notification {
//    NSLog(@"Got notified: %@", notification);
//    int value = [[notification.userInfo objectForKey:@"value"] intValue];
//    if([notification.name isEqualToString: @"noteOn"]) {
//        [_delegate sendNote:true :value];
//    }
//    
//    if([notification.name isEqualToString: @"noteOff"]) {
//        [_delegate sendNote:false :value];
//    }
//    
//    if([notification.name isEqualToString: @"sliderVal"]) {
//        [_delegate sendControlChange: cc :value];
//    }
//    
//}
//
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    NSLog(@"Observer removed");
//}

@end

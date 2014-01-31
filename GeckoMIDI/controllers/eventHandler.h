//
//  eventHandler.h
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 31/01/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eventHandler : NSObject

@property NSObject* observer;
@property NSNotificationCenter* center;

-(void)init;
-(void)receiveTestNotification:(NSNotification *) notification;

@end

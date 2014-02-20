//
//  eventHandler.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 31/01/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@class eventHandler;

@protocol eventHandlerDelegate
-(void)sendNote:(int)note;//(eventHandler*)eventHandler;
@end

@interface eventHandler : NSObject

@property (nonatomic, assign) id delegate;

@property NSObject* observer;
@property NSNotificationCenter* center;

-(id)init;
-(void)midiNotification:(NSNotification*)notification;
-(void)dealloc;

@end

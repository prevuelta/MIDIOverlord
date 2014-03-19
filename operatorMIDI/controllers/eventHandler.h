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
-(void)sendNote:(BOOL)on :(int)note;
@end

@interface eventHandler : NSObject

@property (nonatomic, assign) id delegate;

@property NSObject* observer;
@property NSNotificationCenter* center;

-(id)init;
@end

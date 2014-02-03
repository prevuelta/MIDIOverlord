//
//  controlClass.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlClass.h"
#import "utilities.h"

@implementation controlClass

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    
    return self;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"Clicked");
    [self notify];
   
}

// Posts a MyNotification message whenever called
- (void)notify {
    NSLog(@"Notify");
    NSDictionary* data = [NSDictionary new];
    [utilities notifyWithData:0:data];
}



@end

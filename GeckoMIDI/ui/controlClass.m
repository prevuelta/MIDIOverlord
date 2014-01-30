//
//  controlClass.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlClass.h"

@implementation controlClass

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    
    return self;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

@end

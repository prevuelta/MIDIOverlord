//
//  controlBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/02/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlBase.h"

@implementation controlBase

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    
    return self;
}


-(void)remove {
    NSLog(@"remove function");
}

-(BOOL)isFlipped {
    return NO;
}

-(void)dealloc {
    NSLog(@"Dealloc control");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end


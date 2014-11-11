//
//  uiToggle.m
//  MIDIOverlord
//
//  Created by Pablo on 30/09/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiToggle.h"

@implementation uiToggle

-(id)initWithSize:(int)size {
    
    self = [super initWithFrame:NSMakeRect(0, 0, size, size)];
    
    if(!self) return nil;
    
    [self setIsOn: NO];
    
    return self;
}


-(void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end

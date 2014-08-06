//
//  moduleBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@implementation moduleBase

-(id)initWithHeight:(int)height {
    self.width = RACK_WIDTH - SCROLLER_WIDTH;
    self = [self initWithFrame:NSMakeRect(0, 0, self.width, height)];
    self.height = height;
    return self;
}

-(id)initWithSize:(NSSize)size {
    self = [self initWithFrame:NSMakeRect(0, 0, size.width, size.height)];
    return self;
}
-(id)initWithFrame:(NSRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (!self) return nil;

    self.selected = NO;
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    // Draw background
    
    NSBezierPath* bgPath = [NSBezierPath new];
    
    if(!self.selected) {
        [[global sharedGlobalData].colors[@"lightestGrey"] setFill];
    } else {
        [[global sharedGlobalData].colors[@"red"] setFill];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];

}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

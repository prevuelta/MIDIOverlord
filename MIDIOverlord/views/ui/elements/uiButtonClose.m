//
//  uiButtonClose.m
//  MIDIOverlord
//
//  Created by Pablo on 13/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiButtonClose.h"

NSBezierPath *iconPath;

@implementation uiButtonClose

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;

}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    iconPath = [NSBezierPath new];
    
    [iconPath moveToPoint: NSZeroPoint];
    [iconPath lineToPoint: NSMakePoint(self.frame.size.width, self.frame.size.height)];
    
    [iconPath moveToPoint: NSMakePoint(self.frame.size.width, 0)];
    [iconPath lineToPoint: NSMakePoint(0, self.frame.size.height)];
    
    [self.activeColor setStroke];
    [iconPath stroke];
    
}

@end

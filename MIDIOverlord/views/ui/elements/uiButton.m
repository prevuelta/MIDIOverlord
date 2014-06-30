//
//  uiButton.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/05/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiButton.h"
#import "utilities.h"

@implementation uiButton

-(id)initWithSize:(int)size {
    
    _width = size;
    _height = size;
    
    self = [super initWithFrame: NSMakeRect(0, 0, _width, _height)];
    if (!self) return nil;
    
    self.event = @"";
    self.eventData = @{};
    self.isToggle = NO;
    
//    _iconPoints = @[];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
    
    if(!self.active && !self.toggled) {
        [[global sharedGlobalData].defaultColor setFill];
    } else {
        [[global sharedGlobalData].activeColor setFill];
    }
  
    NSBezierPath *btnPath = [NSBezierPath new];
    [btnPath appendBezierPathWithRoundedRect:dirtyRect xRadius: 2 yRadius:2];
  
    [btnPath fill];
  
    NSBezierPath *iconPath = [NSBezierPath new];

//    for(int i = 0; i < [_iconPoints count]; i++) {
//        if(i == 0) {
//            [iconPath moveToPoint:NSMakePoint(_iconPoints[0], _iconPoints[1])];
//        }
//        if(i % 2 == 0) {
////            []
//        }
//    }
    
}

-(void)setEvent:(NSString*)event withData:(NSDictionary*)data {
    [self setEvent: event];
    [self setEventData: data];
}

-(void)mouseDown:(NSEvent*)theEvent {
    self.active = YES;
    [self setNeedsDisplay:YES];
    
    if(_isToggle) {
        self.toggled = !self.toggled;
        self.eventData = @{@"isToggled" : [NSNumber numberWithBool:self.toggled]};
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName: self.event object:self userInfo: self.eventData];
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = NO;
    [self setNeedsDisplay:YES];
}

@end

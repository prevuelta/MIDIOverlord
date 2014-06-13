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

-(id)initWithFrame:(int)size {
    
    _width = size;
    _height = size;
    
    self = [super initWithFrame: NSMakeRect(0, 0, _width, _height)];
    if (!self) return nil;
    
    self.event = @"";
    self.eventData = @{};
    self.isToggle = NO;
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
    
    if(!self.active && !self.toggled) {
        [self.defaultColor setFill];
    } else {
        [self.activeColor setFill];
    }
    
    NSRectFill(dirtyRect);
    
	[super drawRect:NSMakeRect(0, 0, _width, _height)];
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

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
    
    float defaultRGBA[] = UI_COLOR_PROT_3;
    float markerRGBA[] = UI_COLOR_PROT_4;
    float activeRGBA[] = UI_COLOR_HIGHLIGHT;
    
    _defaultColor = [utilities getNSColorFromRGB:defaultRGBA];
    _markerColor = [utilities getNSColorFromRGB:markerRGBA];
    _activeColor = [utilities getNSColorFromRGB:activeRGBA];
    
    return self;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

- (void)drawRect:(NSRect)dirtyRect{
    
    if(!self.active) {
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
    
    NSLog(@"%@", self.event);
    
    [[NSNotificationCenter defaultCenter] postNotificationName: self.event object:self userInfo: self.eventData];
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = NO;
    [self setNeedsDisplay:YES];
}

@end

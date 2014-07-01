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
    return [self initWithSize:size andIconArray:nil];
}

-(id)initWithSize:(int)size andIconArray:(NSArray*)iconArray  {
    
    _width = size;
    _height = size;
    
    self = [super initWithFrame: NSMakeRect(0, 0, _width, _height)];
    if (!self) return nil;
    
    self.event = @"";
    self.eventData = @{};
    self.isToggle = NO;
    self.isFlipped = YES;
    
    _iconArray = iconArray;

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
    
    int count = (int)[_iconArray count] / 2;
    
    NSPoint iconPointArray[count];
    
    for(int i = 0; i < count; i++) {
            
            CGFloat x = [_iconArray[i*2] floatValue];
            CGFloat y = [_iconArray[i*2+1] floatValue];
            
            iconPointArray[i] = NSMakePoint(x, y);
    }
   
    [iconPath appendBezierPathWithPoints: iconPointArray count: count ];
    
    [[global sharedGlobalData].markerColor setFill];
    
    [iconPath closePath];
    
    [iconPath fill];
    
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

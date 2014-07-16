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
    return [self initWithSize:size andEvent: nil];
}

-(id)initWithSize:(int)size andEvent:(NSString*)event {
    
    _width = size;
    _height = size;
    
    self = [super initWithFrame: NSMakeRect(0, 0, _width, _height)];
    if (!self) return nil;
    
    self.event = @"";
    self.eventData = @{};
    self.isToggle = NO;
    self.flipped = YES;
    
    NSDictionary *iconTypes = @{
         @"addControlRack" : @-48,
         @"addMapRack" : @-48,
         @"editMode" : @-72,
         @"closeWindow" : @0,
         @"closeRack"   : @0
    };
    
//    NSLog(@"Icontype: %@", iconTypes[event] );
    
    if([event length] != 0) {
        [self setEvent: event];
        
        NSImage *icons = [NSImage imageNamed:@"icons.png"];
        _iconView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, icons.size.width, icons.size.height)];
        
        [_iconView setImageScaling: NSImageScaleNone];
        
        [_iconView setImage:icons];

        [self setIconViewOrigin: NSMakePoint([iconTypes[event] intValue], 0)];
        
        [self addSubview:_iconView];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
    
    if(!self.active && !self.toggled) {
        [[global sharedGlobalData].darkBrown setFill];
    } else {
        [[global sharedGlobalData].activeColor setFill];
    }

   NSBezierPath *btnPath = [NSBezierPath new];
//    [btnPath appendBezierPathWithRoundedRect:dirtyRect xRadius: 2 yRadius:2];
    [btnPath appendBezierPathWithRect:dirtyRect ];
  
    [btnPath fill];
    
}

-(void)setIconViewOrigin:(NSPoint)origin {
    NSRect f = _iconView.frame;
    f.origin = origin;
    [_iconView setFrame:f];
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

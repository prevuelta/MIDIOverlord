//
//  scrollableView.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "scrollableView.h"

@implementation scrollableView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _heightOfSubviews = 0;
    
    _originalLocation = NSZeroPoint;
    NSView clippedView=
    
    _scrollBar = [[controlScrollBar alloc] initWithFrame: NSMakeRect(0, 0, SCROLLER_WIDTH, frame.size.height)];
    
    [_scrollBar setOrigin: NSMakePoint(frame.size.width - SCROLLER_WIDTH, 0)];
    
    [self addSubview: _scrollBar];
    
    return self;
}

-(BOOL)isFlipped {
    return YES;
}

-(void)addSubview:(NSView *)aView {
    [super addSubview: aView];
    _heightOfSubviews += aView.frame.size.height;
    if(_heightOfSubviews > self.frame.size.height) {
//        [self addScrollbar];
        NSLog(@"Adding scrollbar");
    }
}

-(void)addScrollBar {
    
}

-(void)drawRect:(NSRect)dirtyRect {
   [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

-(void)setOrigin:(NSPoint)origin {
    [super setOrigin:origin];
    self.originalLocation = origin;
}

- (void)scrollWheel:(NSEvent *)event {
    NSLog(@"Event: %@", [NSNumber numberWithFloat:event.deltaY]);
    int newLocY = self.frame.origin.y + (int)event.deltaY;
    if(newLocY > self.originalLocation.y) {
        [self setOrigin:NSMakePoint(4, newLocY)];
        
    }
}

@end

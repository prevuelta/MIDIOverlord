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
    
    self.isFlipped = YES;
    
    _heightOfSubviews = 0;
    
    _clippedView = [[uiBase alloc] initWithFrame: frame];
    
    _clippedView.isFlipped = YES;
    
    [self addSubview: _clippedView];
    
    _scrollBar = [[controlScrollBar alloc] initWithFrame: NSMakeRect(0, 0, SCROLLER_WIDTH, frame.size.height)];
    
    [_scrollBar setOrigin: NSMakePoint(frame.size.width - SCROLLER_WIDTH, 0)];
    
    [self addSubview: _scrollBar];
    
    return self;
}

-(void)addModuleView:(NSView*)aView {
    [_clippedView addSubview: aView];
    _heightOfSubviews += aView.frame.size.height;
    
    [_clippedView resizeHeight: _heightOfSubviews];
    
    if(_heightOfSubviews > self.frame.size.height) {
        //        [self addScrollbar];
        NSLog(@"Adding scrollbar");
    }
}

-(void)activateScrollBar {
    
}

-(void)deactivateScrollBar {
    
}

-(void)drawRect:(NSRect)dirtyRect {
   [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

- (void)scrollWheel:(NSEvent *)event {
    NSLog(@"Event: %@", [NSNumber numberWithFloat:event.deltaY]);
    int newLocY = self.clippedView.frame.origin.y + (int)event.deltaY;
    if(_clippedView.frame.size.height > self.frame.size.height ||
       _clippedView.frame.origin.y < 0 ) {
        if(event.deltaY >= 0) {
            
        } else {
            [self.clippedView setOrigin:NSMakePoint(0, newLocY)];
        }
    }
}

@end

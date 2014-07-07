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
    
    _clippedView = [[uiBase alloc] initWithFrame: NSMakeRect(0, 0, frame.size.width, 0)];
    
    _clippedView.isFlipped = YES;
    
    [self addSubview: _clippedView];
    
    _scrollBar = [[controlScrollBar alloc] initWithFrame: NSMakeRect(0, 0, SCROLLER_WIDTH, frame.size.height)];
    
    [_scrollBar setOrigin: NSMakePoint(frame.size.width - SCROLLER_WIDTH, 0)];
    
    [self addSubview: _scrollBar];
    
    return self;
}

-(void)resizeHeight:(int)newHeight {
    [super resizeHeight:newHeight];
    [self checkScroll];
    [self checkClippedViewPosition];
}

-(void)checkScroll {
    if(_clippedView.frameHeight > self.frameHeight) {
        [self activateScrollBar];
    } else {
        [self deactivateScrollBar];
    }
}

-(void)checkClippedViewPosition {
    BOOL topAnchorReached = _clippedView.originY >= 0 ? YES : NO;
    BOOL bottomAnchorReached = (_clippedView.originY + _clippedView.frameHeight) < self.frameHeight ? YES : NO;
    
    if(topAnchorReached) {
        [self anchorClippedViewToTop];
    }
    
    if(bottomAnchorReached && !topAnchorReached) {
        [self anchorClippedViewToBottom];
    }
}


-(void)anchorClippedViewToBottom {
     [_clippedView setOrigin:NSMakePoint(0, self.frameHeight - _clippedView.frameHeight)];
}

-(void)anchorClippedViewToTop {
    [_clippedView setOrigin:NSZeroPoint];
}

-(void)addModuleView:(NSView*)aView {
    [_clippedView addSubview: aView];
    _heightOfSubviews += aView.frame.size.height;
    
    [_clippedView resizeHeight: _heightOfSubviews];
    
    if(_heightOfSubviews > self.frame.size.height) {
        [self checkScroll];
    }
}

-(void)activateScrollBar {
    self.scrollBar.active = YES;
}

-(void)deactivateScrollBar {
    [self anchorClippedViewToTop];
    self.scrollBar.active = NO;
}

-(void)drawRect:(NSRect)dirtyRect {
//   [[NSColor whiteColor] setFill];
//    NSRectFill(dirtyRect);
//    [super drawRect:dirtyRect];
}

- (void)scrollWheel:(NSEvent *)event {
    NSLog(@"Event: %@", [NSNumber numberWithFloat:event.deltaY]);
    
    NSLog(@"Event deltaY: %@ FH: %@, CVFH: %@, CPO: %@",
          [NSNumber numberWithFloat: event.deltaY],
          [NSNumber numberWithFloat: self.frameHeight],
          [NSNumber numberWithFloat: _clippedView.frameHeight],
          [NSNumber numberWithFloat: _clippedView.frame.origin.y]);
    
//    if(_clippedView.frame.origin.y <= 0 &&
//        [_clippedView frameHeight] > [self frameHeight] &&
//       _clippedView.frame.origin.y < -([self frameHeight] - [_clippedView frameHeight]) ) {
    
    BOOL scrollActive = self.scrollBar.active;
    
//    NSLog(@"%@, %@", [NSNumber numberWithBool: topAnchorReached], [NSNumber numberWithBool: bottomAnchorReached]);
    
    if(scrollActive) {
        int newLocY = _clippedView.frame.origin.y + event.deltaY;
        [_clippedView setOrigin:NSMakePoint(0, newLocY)];
        [self checkClippedViewPosition];
    }
    
//    if(self.scrollBar.active) {
//        float newLocY = _clippedView.frame.origin.y + event.deltaY;
//        if(_clippedView.frame.origin.y <= 0 && event.deltaY < 0) {
//            NSLog(@"Scrolling up");
//            [_clippedView setOrigin:NSMakePoint(0, newLocY)];
//        }
//        if((_clippedView.frame.origin.y + _clippedView.frameHeight) > self.frameHeight) {
//             NSLog(@"Scrolling Down");
//            [_clippedView setOrigin:NSMakePoint(0, newLocY)];
//        }
//    }
}

@end

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
}

-(void)checkScroll {
    if(_clippedView.frameHeight > self.frameHeight) {
        [self activateScrollBar];
    } else {
        [self deactivateScrollBar];
    }
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
    [self.clippedView setOrigin:NSZeroPoint];
    self.scrollBar.active = NO;
}

-(void)drawRect:(NSRect)dirtyRect {
   [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

- (void)scrollWheel:(NSEvent *)event {
    NSLog(@"Event: %@", [NSNumber numberWithFloat:event.deltaY]);
    
    NSLog(@"Event deltaY: %@ FH: %@, CVFH: %@, CPO: %@",
          [NSNumber numberWithFloat: event.deltaY],
          [NSNumber numberWithFloat: self.frameHeight],
          [NSNumber numberWithFloat: self.clippedView.frameHeight],
          [NSNumber numberWithFloat: self.clippedView.frame.origin.y]);
    
//    if(self.clippedView.frame.origin.y <= 0 &&
//        [self.clippedView frameHeight] > [self frameHeight] &&
//       self.clippedView.frame.origin.y < -([self frameHeight] - [self.clippedView frameHeight]) ) {
    
    BOOL scrollUp = event.deltaY > 0 ? YES : NO;
    BOOL scrollActive = self.scrollBar.active;
    BOOL topAnchorReached = (self.clippedView.originY + event.deltaY) > 0 ? YES : NO;
    BOOL bottomAnchorReached = (self.clippedView.originY + self.clippedView.frameHeight + event.deltaY) < self.frameHeight ? YES : NO;
    
    NSLog(@"%@, %@", [NSNumber numberWithBool: topAnchorReached], [NSNumber numberWithBool: bottomAnchorReached]);
    
    if(scrollActive) {
        if(!topAnchorReached && !bottomAnchorReached ) {
            int newLocY = self.clippedView.frame.origin.y + event.deltaY;
            [self.clippedView setOrigin:NSMakePoint(0, newLocY)];
        }
    }
    
//    if(self.scrollBar.active) {
//        float newLocY = self.clippedView.frame.origin.y + event.deltaY;
//        if(self.clippedView.frame.origin.y <= 0 && event.deltaY < 0) {
//            NSLog(@"Scrolling up");
//            [self.clippedView setOrigin:NSMakePoint(0, newLocY)];
//        }
//        if((self.clippedView.frame.origin.y + self.clippedView.frameHeight) > self.frameHeight) {
//             NSLog(@"Scrolling Down");
//            [self.clippedView setOrigin:NSMakePoint(0, newLocY)];
//        }
//    }
}

@end

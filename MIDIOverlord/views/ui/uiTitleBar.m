//
//  uiTitleBar.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 9/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiTitleBar.h"

@implementation uiTitleBar

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    
//    if([self.window ]) {
        [[global sharedGlobalData].activeColor setFill];
//    } else {
//        [[global sharedGlobalData].bgColor setFill];
//    }
    NSRectFill(dirtyRect);
    
    [super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(void)mouseDown:(NSEvent*)theEvent {
    NSLog(@"Title bar clicked");
}

-(void)mouseUp:(NSEvent *)theEvent {

}

//-(BOOL)mouseDownCanMoveWindow {
//    return YES;
//}

//-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
//    return YES;
//}


@end

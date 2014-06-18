//
//  uiBase.m
//  MIDIOverlord
//
//  Created by Pablo on 10/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiBase.h"

@implementation uiBase

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
        // Initialization code here.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselect:) name:@"deselectAll" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowResizeHandler:) name:NSWindowDidResizeNotification object: nil];
    
    self.inEditView = NO;
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}


-(void)deselect:(NSNotification*)notification  {
    _selected = NO;
    [self setNeedsDisplay:YES];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)windowResizeHandler:(NSNotification*)notification {
}

-(void)resizeHeight:(int)newHeight {
}

-(void)resizeWidth:(int)newWidth {
}

@end

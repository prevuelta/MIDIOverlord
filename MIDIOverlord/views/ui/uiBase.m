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
    
    self.flipped = NO;
    
    self.disabled = false;
    
    return self;
}

-(float)frameHeight {
    return self.frame.size.height;
}

-(float)frameWidth {
    return self.frame.size.width;
}

-(float)originY {
    return self.frame.origin.y;
}

- (void)drawRect:(NSRect)dirtyRect{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)setOriginWithX: (int)x {
    return [self setOrigin:NSMakePoint(x, self.frame.origin.y)];
}

-(void)setOriginWithY: (int)y {
    return [self setOrigin:NSMakePoint(self.frame.origin.x, y)];
}


-(void)setOriginWithX: (int)x andY: (int)y {
    return [self setOrigin:NSMakePoint(x, y)];
}



-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

-(BOOL)isFlipped {
    return _flipped;
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
    NSRect f = self.frame;
    f.size.height = newHeight;
    [self setFrame:f];
    [self setNeedsDisplay:YES];
}

-(void)resizeWidth:(int)newWidth {
    NSRect f = self.frame;
    f.size.width = newWidth;
    [self setFrame:f];
    [self setNeedsDisplay:YES];
}

@end

//
//  uiBase.m
//  MIDIOverlord
//
//  Created by Pablo on 10/06/2014.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiBase.h"
#import "utilities.h"

@implementation uiBase

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
        // Initialization code here.
    
    float blackRGBA[] = UI_COLOR_BLACK;
    float defaultRGBA[] = UI_COLOR_PROT_1;
    float bgRGBA[] = UI_COLOR_PROT_2;
    float markerRGBA[] = UI_COLOR_HIGHLIGHT;
    float activeRGBA[] = UI_COLOR_HIGHLIGHT_2;
    
    _blackColor = [utilities getNSColorFromRGB:blackRGBA];
    _defaultColor = [utilities getNSColorFromRGB:defaultRGBA];
    _bgColor = [utilities getNSColorFromRGB:bgRGBA];
    _markerColor = [utilities getNSColorFromRGB:markerRGBA];
    _activeColor = [utilities getNSColorFromRGB:activeRGBA];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselect:) name:@"deselectAll" object:nil];
    
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




@end

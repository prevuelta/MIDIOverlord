//
//  controlList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlList.h"

@implementation controlList

@synthesize content = _content;
@synthesize selectedIndex = _selectedIndex;

-(id)initWithContent:(NSArray*)content {
    
    int height = 18;

    _label = [[uiTextField alloc] initWithString: @"None" andMaxLength:8];
        
    [_label setDrawBg:NO];
    [_label setOrigin:NSMakePoint(1, 1)];
    
    NSRect frame = NSMakeRect(0, 0, _label.frame.size.width + 20, height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.height = height;
    
    [self setContent: content];
    
    [self addSubview: _label];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    if(self.active) {
        [[global sharedGlobalData].darkBrown set];
    } else {
        [[global sharedGlobalData].defaultColor set];
    }
    
    [bgPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, self.frameWidth, self.height) xRadius: 2 yRadius: 2 ];
    [bgPath closePath];
    [bgPath fill];
    
    [[NSColor whiteColor] set];
    
    // Draw triangles
    if(!self.disabled) {
        [fgPath moveToPoint:NSMakePoint(self.frame.size.width-15, 6)];
        [fgPath lineToPoint:NSMakePoint(self.frame.size.width-5, 6)];
        [fgPath lineToPoint:NSMakePoint(self.frame.size.width-10, 12)];
    
        [fgPath closePath];
        [fgPath fill];
    }
}

-(void)uiEvent:(char*)type {
    NSLog(@"uievetb");
    //   [self uiEvent:type withInt:0];
}

-(BOOL)isFlipped {
    return YES;
}

-(void)mouseDown:(NSEvent*)theEvent {
//    NSLog(@"Whats up");
    [global deselectNotify];
    
    if(self.active) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
//        NSLog(@"settgin selcted");
        self.active = !self.active;
        [self setTag: 20];
        NSRect f = self.frame;
        f.size.height = self.height * ([_content count] + 1);
        self.frame = f;
    }
    
    [self.superview sortSubviewsUsingFunction: compareViews context: NULL];
    [self setNeedsDisplay:YES];
}

-(void)deselect:(NSNotification*)notification {
//    NSLog(@"List deselect");
    self.active = NO;
    [self setTag: 0];
    NSRect f = self.frame;
    f.size.height = self.height;
    self.frame = f;
    [self setNeedsDisplay:YES];
}

NSComparisonResult compareViews(id firstView, id secondView, void *context) {
    
    NSInteger firstTag = [firstView tag];
    NSInteger secondTag = [secondView tag];
    
    if (firstTag == secondTag) {
        return NSOrderedSame;
    } else {
        if (firstTag < secondTag) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }
}

-(NSNumber*)selectedIndex {
    return _selectedIndex;
}

-(void)setSelectedIndex:(NSNumber *)selectedIndex {
    NSLog(@"Setting index");
    [_label setStringValue: [_content[[selectedIndex intValue]] name]];
    _selectedIndex = selectedIndex;
}


-(NSArray*)content {
    return _content;
}

-(void)setContent:(NSArray*)content {
    
//    NSLog(@"Setting content");
    
    _content = content;

    [self setDisabled: !(BOOL)[_content count]];

//    NSLog(@"Disabled: %d %@", (BOOL)[_content count], _content);
    
    NSInteger currentOptionY = self.height;
    
    for(controlOption *option in self.subviews) {
        [option removeFromSuperview];
    }
    
    for(int i = 0; i < [_content count]; i++) {

//        NSLog(@"%@", [_content[i] name]);
        
        NSArray *optionData = @[[NSNumber numberWithInt:i], [_content[i] name]];

        controlOption *option = [[controlOption alloc] initWithKeyValue: optionData]; 

        [option setOrigin:NSMakePoint(0, currentOptionY)];

        option.delegate = self;

        [self addSubview:option];

        currentOptionY += option.frameHeight;
        
//        NSLog(@"Option y %d", currentOptionY);
    }
    
    [self setNeedsDisplay: YES];
}


@end

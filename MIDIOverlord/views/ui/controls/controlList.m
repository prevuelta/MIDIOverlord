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
@synthesize tag = _tag;

-(id)initWithContent:(NSArray*)content {

    int height = 12;

    _label = [[uiTextField alloc] initWithString: @"None" andMaxLength:8];

    [_label setDrawBg:NO];
//    [_label setOrigin:NSMakePoint(1, 1)];

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
        [[global sharedGlobalData].colors[@"yellow"] setFill];
    } else {
        [[global sharedGlobalData].colors[@"lightGrey"] setFill];
    }

    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.frameWidth, self.height)];
    [bgPath closePath];
    [bgPath fill];

    [[global sharedGlobalData].colors[@"darkGrey"] setFill];

    // Draw triangles
    if(!self.disabled) {
        [fgPath moveToPoint:NSMakePoint(self.frame.size.width-12, 4)];
        [fgPath lineToPoint:NSMakePoint(self.frame.size.width-4, 4)];
        [fgPath lineToPoint:NSMakePoint(self.frame.size.width-8, 8)];

        [fgPath closePath];
        [fgPath fill];
    }
}

-(BOOL)isFlipped {
    return YES;
}

-(void)mouseDown:(NSEvent*)theEvent {

    if(self.active) {
        [global deselectNotify];
    } else {
        [global deselectNotify];
        self.active = !self.active;
        [self setTag: 20];
        NSRect f = self.frame;
        f.size.height = self.height * ([_content count] + 2);
        self.frame = f;
    }

    [self.superview sortSubviewsUsingFunction: compareViews context: NULL];
    [self setNeedsDisplay:YES];
}

-(void)deselect:(NSNotification*)notification {
    self.active = NO;
//    [self setTag: 0];
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
    if([selectedIndex intValue] < 0) {
        [_label setStringValue: @"None"];
    } else {
         [_label setStringValue: [_content[[selectedIndex intValue]] name]];
        NSLog(@"Setting selected object..");
        [self setSelectedObject: _content[[selectedIndex intValue]]];
    }
    _selectedIndex = selectedIndex;
}

-(NSArray*)content {
    return _content;
}

-(void)setContent:(NSArray*)content {

    _content = content;

    [self setSubviews: [NSArray array]];

    [self setDisabled: !(BOOL)[_content count]];

    int yLoc = self.height;

    /* None option */

    controlOption *option =  [[controlOption alloc] initWithName: @"None" andIndex: -1];

    option.delegate = self;

    [option setOrigin:NSMakePoint(0, yLoc)];

    [self addSubview: option ];

    yLoc += self.height;

    for(int i = 0; i < [_content count]; i++) {

        NSString *optionName = [_content[i] name];

        controlOption *option =  [[controlOption alloc] initWithName: optionName andIndex: i];

        option.delegate = self;

        [option setOrigin:NSMakePoint(0, yLoc)];

        [self addSubview: option ];

        yLoc += self.height;

    }

    [self setNeedsDisplay: YES];
}

@end

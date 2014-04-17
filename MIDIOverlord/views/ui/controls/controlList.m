//
//  controlList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlList.h"

@implementation controlList


-(id)initWithFrame: (NSMutableArray*)keyValues andLabel:(NSString*)labelText{
    
    self.width = 90;
    self.height = 15;
    
    NSRect frame = NSMakeRect(0, 0, self.width, self.height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    _optionCount = [keyValues count];

    _activeOption = [NSMutableArray arrayWithObjects:labelText, @0, nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselect:) name:@"closeOpen" object:nil];
    
    float bgRGBA[] = UI_COLOR_PROT_2;
    float activeBgRGBA[] = UI_COLOR_PROT_3;
    float fgRGBA[] = UI_COLOR_PROT_4;
    
    _bgColor = [utilities getNSColorFromRGB:bgRGBA];
    _activeBgColor = [utilities getNSColorFromRGB:activeBgRGBA];
    _fgColor = [utilities getNSColorFromRGB:fgRGBA];
    
    uiLabel *label = [[uiLabel alloc] initWithFrame: NSMakeRect(0, 0, self.width, self.height)];
    [label setStringValue: labelText];
    [label setDrawsBackground: NO];
    [self addSubview:label];

    controlOption *optionNone = [[controlOption alloc] initWithFrame: NSMakeRect(0, 0, self.width, self.height)];
    [optionNone setOrigin:NSMakePoint(0, self.height)];
    [optionNone setStringValue: @"None"];
    [self addSubview:optionNone];
    
    controlOption *optionAll = [[controlOption alloc] initWithFrame: NSMakeRect(0, 0, self.width, self.height)];
    [optionAll setOrigin:NSMakePoint(0, self.height * 2)];
    [optionAll setStringValue: @"All"];
    [self addSubview:optionAll];
    
    NSLog(@"Key values: %@", keyValues);

    if([keyValues count] > 0){
        for(int i = 0; i < [keyValues count]; i++ ) {
            
            if(i % 2 == 0) {
                controlOption *option = [[controlOption alloc] initWithFrame: NSMakeRect(0, (i+3) * self.height , self.width, self.height)];
                [option setStringValue: keyValues[i]];
                [option setTag: 5];
                [self addSubview:option];
            
            } else {

            }
        }
    }
    
    return self;
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    if(self.active) {
        [_activeBgColor set];
    } else {
        [_bgColor set];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];
    
    [_fgColor set];
    
    // Draw triangles
    [fgPath moveToPoint:NSMakePoint(self.width-15, 5)];
    [fgPath lineToPoint:NSMakePoint(self.width-5, 5)];
    [fgPath lineToPoint:NSMakePoint(self.width-10, 10)];
    
    [fgPath closePath];
    [fgPath fill];
}

-(BOOL)isFlipped {
    return YES;
}

-(void)mouseDown:(NSEvent*)theEvent {
    NSLog(@"Whats up");
    if(self.selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
        self.selected = !self.selected;
        [self setTag: 20];
        NSRect f = self.frame;
        f.size.height = self.height * (_optionCount + 3);
        self.frame = f;
        
//        [self.superview.layer setZPosition:10];
    }
        
//        [self.superview.superview ]
        
       
        
//        [self removeFromSuperview];
//        [self.superview addSubview:self];
//        [self.superview.subViews removeObject: self];
//        [self.superview addSubview:self positioned:NSWindowAbove relativeTo:nil];
//    } else {
//           NSLog(@"Notactive");
        //        [self.superview addSubview:self];
//        [self.superview addSubview:self positioned:NSWindowBelow relativeTo:nil];
//    }
    
    [self.superview sortSubviewsUsingFunction: compareViews context: NULL];
//    NSLog(@"Tag: %@", [NSNumber numberWithInt:[self tag]]);
//    [self showHideOptions];
    
    [self setNeedsDisplay:YES];
}

-(void)deselect:(NSNotification*)notification {
    NSLog(@"Close notifcation received");
    self.selected = NO;
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


@end

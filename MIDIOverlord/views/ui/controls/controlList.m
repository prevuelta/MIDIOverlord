//
//  controlList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlList.h"

@implementation controlList

@synthesize selectedOption = _selectedOption;
@synthesize options = _options;


-(id)initWithOptions:(NSMutableDictionary*)options andOptionCount: (int)optionCount {
    
    self.height = 16;
    
   _label = [[uiTextField alloc] initWithString: @"" andMaxLength:6];
    
    NSRect frame = NSMakeRect(0, 0, _label.frame.size.width + 20, self.height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    _optionCount = optionCount;
    
    [self setOptions: options];
    
    [self addSubview: _label];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    if(self.active) {
        [[global sharedGlobalData].activeColor set];
    } else {
        [[global sharedGlobalData].defaultColor set];
    }
    
    [bgPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, self.width, self.height) xRadius: 2 yRadius: 2 ];
    [bgPath closePath];
    [bgPath fill];
    
    [[global sharedGlobalData].markerColor set];
    
    // Draw triangles
    [fgPath moveToPoint:NSMakePoint(self.frame.size.width-15, 6)];
    [fgPath lineToPoint:NSMakePoint(self.frame.size.width-5, 6)];
    [fgPath lineToPoint:NSMakePoint(self.frame.size.width-10, 12)];
    
    [fgPath closePath];
    [fgPath fill];
}

-(void)uiEvent:(char*)type {
    NSLog(@"uievetb");
    //   [self uiEvent:type withInt:0];
}

-(BOOL)isFlipped {
    return YES;
}

-(void)mouseDown:(NSEvent*)theEvent {
    NSLog(@"Whats up");
    [global deselectNotify];
    
    if(self.selected) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
    } else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
        NSLog(@"settgin selcted");
        self.selected = !self.selected;
        [self setTag: 20];
        NSRect f = self.frame;
        f.size.height = self.height * (_optionCount + 1);
        self.frame = f;
    }
    
    [self.superview sortSubviewsUsingFunction: compareViews context: NULL];
    [self setNeedsDisplay:YES];
}

-(void)deselect:(NSNotification*)notification {

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

-(NSArray*)selectedOption {
    return _selectedOption;
}


-(void)setSelectedOption: (NSArray*)selectedOption {
    [_label setStringValue: selectedOption[0]];
    _selectedOption = selectedOption;
}


-(NSMutableDictionary*)options {
    return _options;
}

-(void)setOptions:(NSMutableDictionary*)options {

    _options = options;
    
    NSInteger currentOptionY = self.height;
    
    NSLog(@"Set options: %@", _options);
    
    for(NSNumber* key in _options) {
        NSLog(@"key: %@", key);
        NSArray *optionData = @[[_options objectForKey: key], key];
        controlOption *option = [[controlOption alloc] initWithKeyValue: optionData];
        [option setOrigin:NSMakePoint(0, currentOptionY)];
         option.delegate = self;
        [self addSubview:option];
        currentOptionY += self.height;
    }
    
    [self setNeedsDisplay: YES];
}

-(void)optionSelectedWithKeyValue: (NSArray*)keyValue {
    NSLog(@"Delegate Received %@", keyValue);
    [self setSelectedOption: keyValue];
    NSLog(@"keyValue: %@", keyValue[0]);
}


@end

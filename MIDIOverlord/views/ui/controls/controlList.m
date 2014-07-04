//
//  controlList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 18/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlList.h"

@implementation controlList

@synthesize selectedValue = _selectedValue;

-(id)initWithOptions:(NSMutableDictionary*)options andOptionCount: (int)optionCount {
    
    self.width = 96;
    self.height = 20;
    
    NSRect frame = NSMakeRect(0, 0, self.width, self.height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    _optionCount = optionCount;

    _selectedLabel = [[uiText alloc] initWithString: @"OPTION"];
    
    [self addSubview:_selectedLabel];
    
//    _activeOption = [NSMutableArray arrayWithObjects:labelText, @0, nil];
    
    _selectedValue = 0;
    
    return self;
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    if(self.active) {
        [[global sharedGlobalData].activeColor set];
    } else {
        [[global sharedGlobalData].defaultColor set];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];
    
    [[global sharedGlobalData].markerColor set];
    
    // Draw triangles
    [fgPath moveToPoint:NSMakePoint(self.width-15, 5)];
    [fgPath lineToPoint:NSMakePoint(self.width-5, 5)];
    [fgPath lineToPoint:NSMakePoint(self.width-10, 10)];
    
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
        self.selected = !self.selected;
        [self setTag: 20];
        NSRect f = self.frame;
        f.size.height = self.height * (_optionCount + 1);
        self.frame = f;
    }

//    [self updateValues];
    
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

-(int)selectedValue {
    return _selectedValue;
}


-(void)setSelectedLabel:(NSString*)selectedLabel {
     [_selectedLabel setStringValue: selectedLabel];
}

-(void)setSelectedValue:(int)selectedValue {
    _selectedValue = selectedValue;
}

// Hooks
-(void)updateValues {
    
    _optionCount = [_optionData count] / 2;

    NSInteger currentOptionY = self.height;
    
    if([_optionData count] > 0){
        for(int i = 0; i < [_optionData count]; i++ ) {
            NSLog(@"Option data: %@", _optionData[i]);
            if(i % 2 == 0) {
                NSLog(@"OPtion added");
                NSArray *optionData = @[ _optionData[i], _optionData[i+1]];
                controlOption *option = [[controlOption alloc] initWithFrame: NSMakeRect(0, 0, self.width, self.height) andKeyValue: optionData];
                [option setOrigin:NSMakePoint(0, currentOptionY)];
                option.delegate = self;
                [self addSubview:option];
                currentOptionY += self.height;
                NSLog(@"Current height: %d", currentOptionY);
            } else {
                
            }
        }
    }
    
    [self setNeedsDisplay: YES];
}


-(void)optionSelectedWithKeyValue: (NSArray*)keyValue {
    NSLog(@"Delegate Received %@", keyValue);
   [self setSelectedLabel: keyValue[0]];
   [self setSelectedValue: (int)[keyValue[1] integerValue]];
    NSLog(@"keyValue: %@", keyValue[1]);
}


@end

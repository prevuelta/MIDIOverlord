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

-(id)initWithFrame: (NSString*)labelText {
    
    self.width = 90;
    self.height = 15;
    
    NSRect frame = NSMakeRect(0, 0, self.width, self.height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;

    _labelText = labelText;
    
    [self setDefaults];
    
//    _optionData = keyValues;

    _optionData = [NSMutableArray new];
    
    [self addOptions];
    
    _selectedLabel = [[uiLabel alloc] initWithFrame: NSMakeRect(0, 0, self.width, self.height)];
    [_selectedLabel setStringValue: _labelText];
    [_selectedLabel setDrawsBackground: NO];
    [self addSubview:_selectedLabel];

    _optionCount = [_optionData count] / 2;
    
    _activeOption = [NSMutableArray arrayWithObjects:labelText, @0, nil];
    
    _selectedValue = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselect:) name:@"closeOpen" object:nil];
    
//    float bgRGBA[] = UI_COLOR_PROT_2;
//    float activeBgRGBA[] = UI_COLOR_PROT_3;
//    float fgRGBA[] = UI_COLOR_PROT_4;
//    
//    _bgColor = [utilities getNSColorFromRGB:bgRGBA];
//    _activeBgColor = [utilities getNSColorFromRGB:activeBgRGBA];
//    _fgColor = [utilities getNSColorFromRGB:fgRGBA];
//

    [self updateValues];
    
    return self;
}

-(void)drawRect:(NSRect)rect {
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    if(self.active) {
        [self.activeColor set];
    } else {
        [self.defaultColor set];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];
    
    [self.markerColor set];
    
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
//    NSLog(@"Close notifcation received");
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
// _selectedLabel = selectedLabel
     [_selectedLabel setStringValue: selectedLabel];
     [_selectedLabel setNeedsDisplay: YES];
    ;
}

-(void)setSelectedValue:(int)selectedValue {
    _selectedValue = selectedValue;
}

// Hooks
-(void)updateValues {
    
//    [_selectedLabel setStringValue: _labelText];
    
    _optionCount = [_optionData count] / 2;

    NSInteger currentOptionY = self.height;
    
    if([_optionData count] > 0){
        for(int i = 0; i < [_optionData count]; i++ ) {
            NSLog(@"Option data: %@", _optionData[i]);
            if(i % 2 == 0) {
                NSLog(@"OPtion added");
                NSArray *optionData = @[ _optionData[i], _optionData[i+1]];
                controlOption *option = [[controlOption alloc] initWithFrame: NSMakeRect(0, 0, self.width, self.height)];
                [option setOrigin:NSMakePoint(0, currentOptionY)];
                [option setKeyValue:optionData];
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

-(void)addOptions {
    // Add options hook
}

-(void)optionSelectedWithKeyValue: (NSArray*)keyValue {
    NSLog(@"Delegate Received %@", keyValue);
   [self setSelectedLabel: keyValue[0]];
   [self setSelectedValue: (int)[keyValue[1] integerValue]];
    NSLog(@"keyValue: %@", keyValue[1]);
}


@end

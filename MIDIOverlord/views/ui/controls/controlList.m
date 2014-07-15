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
    
    int height = 18;
    
   _label = [[uiTextField alloc] initWithString: @"" andMaxLength:8];
    
    _nullOption = @[@"None", @0];
    
    [_label setDrawBg:NO];
    [_label setOrigin:NSMakePoint(1, 1)];
    
    NSRect frame = NSMakeRect(0, 0, _label.frame.size.width + 20, height);
    
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    self.height = height;
    
    _optionCount = optionCount + 1; // Add none option
    
    [self setOptions: options];
    
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
    
    if(self.active) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
        NSLog(@"settgin selcted");
        self.active = !self.active;
        [self setTag: 20];
        NSRect f = self.frame;
        f.size.height = self.height * (_optionCount + 1);
        self.frame = f;
    }
    
    [self.superview sortSubviewsUsingFunction: compareViews context: NULL];
    [self setNeedsDisplay:YES];
}

-(void)deselect:(NSNotification*)notification {
    NSLog(@"List deselect");
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

-(NSArray*)selectedOption {
    return _selectedOption;
}


-(void)setSelectedOption: (NSArray*)selectedOption {
    [_label setStringValue: selectedOption[0]];
    _selectedOption = selectedOption;
    [self setNeedsDisplay:YES];
}


-(NSMutableDictionary*)options {
    return _options;
}

-(void)setOptions:(NSMutableDictionary*)options {
    
    [options setObject: _nullOption[0] forKey: _nullOption[1] ];
    
    [self setSelectedOption: _nullOption ];
    
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
        
        currentOptionY += option.frameHeight;
    }
    
    [self setNeedsDisplay: YES];
}

-(void)optionSelectedWithKeyValue: (NSArray*)keyValue {
    NSLog(@"Delegate Received %@", keyValue);
    [self setSelectedOption: keyValue];
    NSLog(@"keyValue: %@", keyValue[0]);
}


@end

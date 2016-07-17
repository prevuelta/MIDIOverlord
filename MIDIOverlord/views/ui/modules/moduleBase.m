//
//  moduleBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@implementation moduleBase

@synthesize tag = _tag;
@synthesize isMapping = _isMapping;

-(id)initWithData:(NSMutableDictionary*)data {
    // Is overwritten in child classes
    return self;
}

-(id)initWithUnitWidth:(NSNumber*)unitWidth andUnitHeight:(NSNumber*)unitHeight {
    _unitHeight = [unitHeight intValue];
    _unitWidth = [unitWidth intValue];
    self.width = [self getWidth];
    self.height = [self getHeight];
    self = [self initWithFrame:NSMakeRect(0, 0, self.width, self.height)];
    return self;
}

-(id)initWithFrame:(NSRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    
    self.selected = NO;
    
    _MIDIIdentifier = [global uuid];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopMapping:) name:@"stopMapping" object:nil];
    
    
    return self;
}

-(int)getWidth {
    return UNIT_WIDTH * self.unitWidth;
}

-(int)getHeight {
    return UNIT_HEIGHT * self.unitHeight;
}


-(void)drawRect:(NSRect)dirtyRect {
    // Draw background
//    
    NSBezierPath* bgPath = [NSBezierPath new];
    
    if(!self.selected) {
        [[global sharedGlobalData].colors[@"brown"] setFill];
    } else {
        [[global sharedGlobalData].colors[@"brown"] setFill];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];

}

-(MIKMIDIResponderType)MIDIResponderTypeForCommandIdentifier:(NSString *)commandID {
    return MIKMIDIResponderTypePressReleaseButton;
}

-(NSArray*)commandIdentifiers {
    NSArray *cId = [NSArray new];
    return cId;
}

-(BOOL)isMapping {
    return _isMapping;
}

-(void)setIsMapping:(BOOL)isMapping {
    if(isMapping) {
        [self.delegate startMap: @{self.MIDIIdentifier : @"note"}];
    }
    _isMapping = isMapping;
}

-(void)stopMapping:(NSNotification*)notification {
    // Overwritten by sub-classes
}

-(void)handleMIDICommand:(NSNotification*)notification {
//    if([self.receiveCommand
    NSLog(@"Command received to module");
}

-(void)dealloc {
    NSLog(@"Module dealloc: %@", self.data[@"type"]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

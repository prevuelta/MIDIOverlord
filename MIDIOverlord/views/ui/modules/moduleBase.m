//
//  moduleBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@implementation moduleBase

-(id)initWithData:(NSMutableDictionary*)data {
    // Is overwritten in child classes
    return self;
}

-(id)initWithUnitWidth:(int)unitWidth andUnitHeight:(int)unitHeight {
    _unitHeight = unitHeight;
    _unitWidth = unitWidth;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopRecording:) name:@"stopRecording" object:nil];
    
    
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
//    NSBezierPath* bgPath = [NSBezierPath new];
//    
//    if(!self.selected) {
//        [[global sharedGlobalData].colors[@"darkestGrey"] setFill];
//    } else {
//        [[global sharedGlobalData].colors[@"red"] setFill];
//    }
//    
//    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
//    [bgPath closePath];
//    [bgPath fill];

}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(MIKMIDIResponderType)MIDIResponderTypeForCommandIdentifier:(NSString *)commandID {
    return MIKMIDIResponderTypePressReleaseButton;
}

-(NSArray*)commandIdentifiers {
    NSArray *cId = [NSArray new];
    return cId;
}

-(void)stopRecording:(NSNotification*)notification {
    
}

-(BOOL)respondsToMIDICommand:command {
//    [command comp]
    
    return YES;
}

-(void)handleMIDICommand:(NSNotification*)notification {
//    if([self.receiveCommand
    NSLog(@"Command received to module");
}


@end

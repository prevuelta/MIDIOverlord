//
//  rackBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "rackBase.h"

@implementation rackBase

@synthesize data = _data;
@synthesize subViews;

-(id)initWithFrame:(NSRect)frame andData:(NSMutableDictionary*)data {
    
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.width = RACK_WIDTH;
    
    self.height = WINDOW_HEIGHT;
    
    self.headerHeight = 100;
    
    self.subViews = [NSMutableArray new];
    
    self.midiChannel = 0;
    
    self.labelText = @"Untititled";
    
    [self setSelected:NO];
    
    self.labelText = data[@"label"];
    
    self.rackID = data[@"rackID"];
    
    self.data = data;
    
    self.label = [[uiText alloc] initWithString: self.labelText];
    
    [self addSubview: self.label];
//
//    _midiChannelText = [uiText initWithString: @"CH000" andMaxLength: 5 andLabelLength: 2];
    
//    [_midiChannelText setOrigin:NSMakePoint(0, 24)];
    
//    [_midiChannelText setEditable: YES];
    
//    [_midiChannelText bind:@"value" toObject:self withKeyPath:@"self.midiChannel" options:nil];
    
    [self addSubview: _midiChannelText];
    
    [self addRackTitle];
    
    // Observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createMidiDestinationsDeviceList:) name:@"updateMidiDestinations" object:nil];

    return self;
}

-(void)addRackTitle {

    // Overridden

}

-(BOOL)isFlipped {
    return YES;
}

-(void)drawRect:(NSRect)rect {
    
    // Draw background
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    int strokeWidth = 4;
    int halfStrokeWidth = strokeWidth / 2;
    
    if(self.selected == YES) {
        [self.activeColor set];
    } else {
        [self.blackColor set];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, RACK_WIDTH, self.headerHeight)];
    
    [bgPath closePath];
    [bgPath fill];
    
    [fgPath moveToPoint:NSMakePoint(halfStrokeWidth, halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(self.width - halfStrokeWidth, halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(self.width - halfStrokeWidth, WINDOW_HEIGHT - halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(halfStrokeWidth, WINDOW_HEIGHT - halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(halfStrokeWidth, halfStrokeWidth)];
    
    [fgPath closePath];
    
    [fgPath setLineWidth: strokeWidth];
    
    [fgPath stroke];
    
//    NSLog(@"Drawing");
}

-(void)midiData:(NSArray*)data {
    NSDictionary *newData = @{@"device": [NSNumber numberWithInt: self.deviceOut], @"data" : data};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessage" object:self userInfo: data];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessageToDevice" object:self userInfo: newData];
        //        [utilities midiNotification: 0xB0 : self.midiValue :value];
}

-(void)moduleUpdateWithData: (NSDictionary*)data {
//    NSLog(@"Send Notification: %@", data);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moduleUpdate" object:self userInfo: @{@"rackID": self.rackID, @"data": data}];
}

-(void)mouseDown:(NSEvent *)theEvent {
//    NSLog(@"Slected");
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
//    self.selected = YES;
//    [self setNeedsDisplay:YES];
}

@end
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
    
    float blackRGBA[] = UI_COLOR_BLACK;
    float defaultRGBA[] = UI_COLOR_PROT_2;
    float markerRGBA[] = UI_COLOR_HIGHLIGHT;
    float activeRGBA[] = UI_COLOR_HIGHLIGHT_2;
    
    _defaultColor = [utilities getNSColorFromRGB:defaultRGBA];
    _blackColor = [utilities getNSColorFromRGB:blackRGBA];
    _markerColor = [utilities getNSColorFromRGB:markerRGBA];
    _activeColor = [utilities getNSColorFromRGB:activeRGBA];
    
    self.width = RACK_WIDTH;
    
    self.height = WINDOW_HEIGHT;
    
    self.headerHeight = 100;
    
    self.subViews = [NSMutableArray new];
    
    self.midiChannel = 0;
    
    self.labelText = @"Untititled";
    
    _selected = NO;
    
    self.labelText = [data objectForKey: @"label"];
    
    self.rackID = [data objectForKey: @"rackID"];
    
    NSLog(@"Rack id: %@", self.rackID);
    
    self.label = [[controlText alloc] initWithString: self.labelText];
    
    [self addSubview: self.label];
    
    _midiChannelText = [[controlText alloc] initWithString: @"CH000" andMaxLength: 5 andLabelLength: 2];
    
    [_midiChannelText setOrigin:NSMakePoint(0, 24)];
    
    [_midiChannelText setEditable: YES];
    
    [_midiChannelText bind:@"value" toObject:self withKeyPath:@"self.midiChannel" options:nil];
    
    [self addSubview: _midiChannelText];
    
    [self addRackTitle];
    
    // Observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createMidiDestinationsDeviceList:) name:@"updateMidiDestinations" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselect:) name:@"deselectAll" object:nil];
    
    
    
   
    
    return self;
}

-(void)addRackTitle {

    // Overridden

}

-(BOOL)isFlipped {
    return YES;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

-(void)deselect:(NSNotification*)notification  {
    _selected = NO;
    [self setNeedsDisplay:YES];
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

-(void)midiData:(NSDictionary*)data {
    NSDictionary *newData = @{@"device": [NSNumber numberWithInt: self.deviceOut], @"data" : data};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessage" object:self userInfo: data];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessageToDevice" object:self userInfo: newData];
        //        [utilities midiNotification: 0xB0 : self.midiValue :value];
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"Slected");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
    self.selected = YES;
    [self setNeedsDisplay:YES];
}

@end
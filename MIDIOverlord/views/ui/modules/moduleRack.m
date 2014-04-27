//
//  rack.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 21/03/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleRack.h"

@implementation moduleRack

@synthesize data = _data;
@synthesize subViews;

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.width = WINDOW_WIDTH;
    
    self.height = RACK_HEIGHT;
    
    self.headerWidth = 100;
    
    [self addRackTitle];
    
    float bgRGBA[] = UI_COLOR_PROT_0;
    
    self.bgColor = [utilities getNSColorFromRGB: bgRGBA];
    
    self.subViews = [NSMutableArray new];
    
    return self;
}

-(void)addRackTitle {

    self.label = [[uiLabel alloc] initWithFrame:NSMakeRect(0, 0, self.headerWidth, 15)];
    [self.label setStringValue: self.labelText];
    
    [self addSubview: self.label];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getMidiDestinations" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createMidiDestinationsDeviceList:) name:@"midiDestinations" object:nil];
    // Destinations
//    NSMutableArray* destinations = [utilities getMidiDestinations];
//    deviceList *midiOutput = [[deviceList alloc] initWithFrame: destinations andLabel: @"MIDI OUT"];
//    [midiOutput setOrigin: NSMakePoint(5, 20)];
//    [self addSubview: midiOutput];
    
    // Origins
//    NSMutableArray* sources = [utilities getMidiSources];
//    deviceList *midiInput = [[deviceList alloc] initWithFrame:sources andLabel: @"MIDI IN"];
//    [midiInput setOrigin: NSMakePoint(5, 40)];
//    [self addSubview: midiInput];
    
    
    [self setNeedsDisplay:YES];
    
}


-(void)createMidiDestinationsDeviceList:(NSNotification*)notification {
  NSLog(@"Devices: %@", notification);
}

-(NSDictionary*)data {
    return _data;
}

-(void)setData:(NSDictionary*)data {
    self.labelText = [data objectForKey: @"label"];
    self.tag = [[data objectForKey:@"ID"] integerValue];
    _data = data;
}

-(BOOL)isFlipped {
    return YES;
}

-(void)drawBg:(NSRect)rect {
    
    // Draw background
    
    NSBezierPath* bgPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    int strokeWidth = 4;
    int halfStrokeWidth = strokeWidth / 2;
    
    if(self.selected) {
        [self.selectedColor set];
    } else {
        [self.bgColor set];
    }
    
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.headerWidth, RACK_HEIGHT)];
    
    [bgPath closePath];
    [bgPath fill];
    
    [fgPath moveToPoint:NSMakePoint(halfStrokeWidth, halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(self.width - halfStrokeWidth, halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(self.width - halfStrokeWidth, RACK_HEIGHT - halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(halfStrokeWidth, RACK_HEIGHT - halfStrokeWidth)];
    [fgPath lineToPoint:NSMakePoint(halfStrokeWidth, halfStrokeWidth)];
    
    [fgPath closePath];
    
    [fgPath setLineWidth: strokeWidth];
    
    [fgPath stroke];
    
//    NSLog(@"Drawing");
}


@end
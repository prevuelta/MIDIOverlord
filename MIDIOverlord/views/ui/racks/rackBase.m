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

-(id)initWithFrame:(NSRect)frame {
    
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
    
    [self addRackTitle];
    
    float bgRGBA[] = UI_COLOR_PROT_0;
    
    self.bgColor = [utilities getNSColorFromRGB: bgRGBA];
    
    self.subViews = [NSMutableArray new];
    
    self.midiChannel = 0;
    
    _selected = NO;
    
    NSLog(@"Sending");
    
    _midiChannelText = [[controlText alloc] initWithFrame: _midiChannel andLabel: @"CH" andMaxVal: 16];
    
    [_midiChannelText setOrigin:NSMakePoint(0, 24)];
    
    [_midiChannelText setEditable: YES];
    
    [_midiChannelText bind:@"value" toObject:self withKeyPath:@"self.midiChannel" options:nil];
    
    [self addSubview: _midiChannelText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createMidiDestinationsDeviceList:) name:@"updateMidiDestinations" object:nil];
    
    return self;
}

-(void)addRackTitle {

    self.label = [[controlText alloc] initWithFrame: -1 andLabel: self.labelText andMaxVal: 0];
    
    [self addSubview: self.label];
    
    _midiInput = [[deviceList alloc] initWithFrame: @"MIDI IN"];
    [_midiInput setOrigin: NSMakePoint(0, 36)];
    
    [self addSubview: _midiInput];
    
    _midiOutput = [[deviceList alloc] initWithFrame: @"MIDI OUT"];
    [_midiOutput setOrigin: NSMakePoint(0, 48)];
    
    [self bind:@"deviceOut" toObject:_midiOutput withKeyPath:@"selectedValue" options:nil];
    
    [self addSubview: _midiOutput];
    
    [self setNeedsDisplay:YES];
    
}


-(void)createMidiDestinationsDeviceList:(NSNotification*)notification {
  NSLog(@"Devices: %@", notification);
    NSLog(@"%@", notification.userInfo);
    //    NSDictionary data = @{notification.object[0]}
    NSMutableArray *keyValues = [NSMutableArray new];
    for(NSString* key in notification.userInfo) {
        [keyValues addObject: [notification.userInfo objectForKey: key][0]];
        [keyValues addObject: key];
    }
    NSLog(@"New device array %@", keyValues);
    
    [_midiOutput addOptions: keyValues];
}

-(NSDictionary*)data {
    return _data;
}

-(void)setData:(NSDictionary*)data {
    self.labelText = [data objectForKey: @"label"];
    NSLog(@"Label yo%@", self.labelText);
    self.tag = [[data objectForKey:@"ID"] integerValue];
    _data = data;
}

-(BOOL)isFlipped {
    return YES;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
    _selected = YES;
    [self setNeedsDisplay:YES];
}

@end
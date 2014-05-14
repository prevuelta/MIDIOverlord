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
    
    self.midiChannel = 0;
    
    NSLog(@"Sending");
    
    _midiChannelText = [[controlText alloc] initWithFrame: _midiChannel andLabel: @"CH"];
    
    [_midiChannelText setOrigin:NSMakePoint(0, MODULE_HEIGHT - 32)];
    
    [_midiChannelText bind:@"value" toObject:self withKeyPath:@"self.midiChannel" options:nil];
    
    [self addSubview: _midiChannelText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createMidiDestinationsDeviceList:) name:@"updateMidiDestinations" object:nil];
    
    return self;
}

-(void)addRackTitle {

    self.label = [[uiLabel alloc] initWithFrame:NSMakeRect(0, 0, self.headerWidth, 15)];
    [self.label setStringValue: self.labelText];
    
    [self addSubview: self.label];
    
    _midiInput = [[deviceList alloc] initWithFrame: @"MIDI IN"];
    [_midiInput setOrigin: NSMakePoint(5, 20)];
    
    [self addSubview: _midiInput];
    
    _midiOutput = [[deviceList alloc] initWithFrame: @"MIDI OUT"];
    [_midiOutput setOrigin: NSMakePoint(5, 40)];
    
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

-(void)midiData:(NSDictionary*)data {
    NSDictionary *newData = @{@"device": [NSNumber numberWithInt: self.deviceOut], @"data" : data};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessage" object:self userInfo: data];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessageToDevice" object:self userInfo: newData];
        //        [utilities midiNotification: 0xB0 : self.midiValue :value];
}


@end
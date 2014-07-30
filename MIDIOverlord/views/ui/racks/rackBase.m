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
@synthesize labelText = _labelText;

-(id)initWithFrame:(NSRect)frame andData:(NSMutableDictionary*)data {
    
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.width = RACK_WIDTH;
    
    self.height = frame.size.height - TOOLBAR_HEIGHT - 30;
    
    NSLog(@"Height %@", [NSNumber numberWithInt:self.height]);
    
    self.headerHeight = 84;
    
    self.subViews = [NSMutableArray new];
    
    self.labelText = @"Untititled";
    
    [self setSelected:NO];
    
    self.labelText = data[@"label"];
    
    self.rackID = data[@"rackID"];
    
    self.midiDest = data[@"midiDest"];
    
    self.data = data;
    
    self.moduleView = [[scrollableView alloc] initWithFrame:NSMakeRect(0, 0, RACK_WIDTH - 8, self.height - self.headerHeight - 4)];
    
    [self.moduleView setOrigin: NSMakePoint(4, self.headerHeight)];
//
    [self addSubview: self.moduleView];
    
    self.label = [[uiEditableTextField alloc] initWithString: self.labelText andMaxLength:14];
    [self.label setDrawBg: NO];
    [self.label setOrigin:NSMakePoint(4, 4)];
    
    [self bind:@"labelText" toObject: _label withKeyPath:@"stringValue" options:nil];
    
    [self addSubview: self.label];
    
//    [self.data bind:@"stringValue" toObject: self withKeyPath:@:self.labelText options:nil];
//
//    _midiChannelText = [uiTextField initWithString: @"CH000" andMaxLength: 5 andLabelLength: 2];
    
//    [_midiChannelText setOrigin:NSMakePoint(0, 24)];
    
//    [_midiChannelText setEditable: YES];
    
//    [_midiChannelText bind:@"value" toObject:self withKeyPath:@"self.midiChannel" options:nil];
    
//    [self addSubview: _midiChannelText];
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12];
    [removeBtn setEvent:@"removeRack" withData: @{@"rackID": self.rackID}];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 16, 4)];
    [removeBtn setInEditView:YES];
    
    [self addSubview: removeBtn];
    
    [self addRackTitle];

    return self;
}

-(void)addRackTitle {
    // Overridden
}

-(BOOL)isFlipped {
    return YES;
}

-(NSString*)labelText{
    return _labelText;
}

-(void)setLabelText:(NSString*)labelText {
    self.data[@"label"] = labelText;
    _labelText = labelText;
}

-(void)drawRect:(NSRect)rect {
    
    // Draw background
    
    NSBezierPath* headerPath = [NSBezierPath new];
    NSBezierPath* fgPath = [NSBezierPath new];
    
    if(self.selected == YES) {
        [[global sharedGlobalData].activeColor set];
    } else {
        [[global sharedGlobalData].darkestGrey set];
    }
    
    [headerPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, RACK_WIDTH, self.headerHeight) xRadius: 0 yRadius: 0];
    
    [headerPath closePath];
    [headerPath fill];
    
    [fgPath moveToPoint:NSZeroPoint];
    [fgPath lineToPoint:NSMakePoint(0, self.headerHeight)];
    [fgPath lineToPoint:NSMakePoint(0, self.height)];
    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH, self.height)];
    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH, self.headerHeight)];
    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH - 4, self.headerHeight)];
    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH - 4, self.height-4)];
    [fgPath lineToPoint:NSMakePoint(4, self.height-4)];
    [fgPath lineToPoint:NSMakePoint(4, 4)];
    [fgPath lineToPoint:NSMakePoint(4, self.headerHeight)];
    [fgPath lineToPoint:NSMakePoint(0, self.headerHeight)];
    
    [fgPath fill];
    

    
//    NSLog(@"Drawing");
}

-(void)windowResizeHandler:(NSNotification*)notification {
    //    int height = notification.object.Size.height;
    NSLog(@"Window resize: %@", notification);
    NSWindow *win = notification.object;
    [self resizeHeight: win.frame.size.height];
    [self.moduleView resizeHeight: self.height - self.headerHeight - 4];
    [self.moduleView.scrollBar resizeHeight: self.height - self.headerHeight - 4];
}

-(void)resizeHeight:(int)newHeight {
    self.height = newHeight - TOOLBAR_HEIGHT - 30;
    NSRect f = self.frame;
    f.size.height = self.height;
    [self setFrame:f];
    [self setNeedsDisplay:YES];
}

-(void)midiCommand:(NSArray*)data {
    
    NSLog(@"Delegate recieved: %@", _data[@"channel"]);
    if([[_midiDeviceController selectedObjects] count]) {
         NSError *error = nil;
        MIKMutableMIDIControlChangeCommand *command = [[MIKMutableMIDIControlChangeCommand alloc] init];
        

        [command setCommandType: [data[0] unsignedIntegerValue]];
        [command setControllerNumber: [data[1] unsignedIntegerValue]];
        [command setControllerValue: [data[2] unsignedIntegerValue]];
        
        [command setChannel: (Byte)[_data[@"channel"] unsignedShortValue]];
        
        
        NSLog(@"command: %@", command);
        
        NSArray *commands = @[command];
        
        MIKMIDIDestinationEndpoint *endpoint = [_midiDeviceController selectedObjects][0];
        
        [[MIKMIDIDeviceManager sharedDeviceManager] sendCommands: commands toEndpoint: endpoint error: &error ];
    }
}

-(void)midiData:(NSArray*)data {
    
    if([[_midiDeviceController selectedObjects] count]) {
        NSError *error = nil;
        
        NSLog(@"Status byte: %d", [utilities getMidiPacket: data]);

        MIDIPacket midiPacket = [utilities getMidiPacket: data]->packet[0];
        
        MIKMutableMIDICommand *command = [[MIKMutableMIDICommand commandWithMIDIPacket: &midiPacket] mutableCopy];
        
        [command setDataByte1: midiPacket.data[1]];
        
        NSLog(@"command: %@", command);
        
        NSArray *commands = @[command];
        
        MIKMIDIDestinationEndpoint *endpoint = [_midiDeviceController selectedObjects][0];
        
        [[MIKMIDIDeviceManager sharedDeviceManager] sendCommands: commands toEndpoint: endpoint error: &error ];
        
        NSLog(@"Error: %@", [error localizedDescription]);
    }

}

-(void)mouseDown:(NSEvent *)theEvent {
//    NSLog(@"Slected");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
//    self.selected = YES;
//    [self setNeedsDisplay:YES];
}

@end
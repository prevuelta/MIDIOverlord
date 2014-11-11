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
    
    [self setData: data];
    
    self.width = RACK_WIDTH;
    
    self.height = frame.size.height - TOOLBAR_HEIGHT - TITLE_BAR_HEIGHT - 12;
    
    self.headerHeight = 96;
    
    [self setSelected:NO];
    
    self.moduleView = [[scrollableView alloc] initWithFrame:NSMakeRect(0, 0, RACK_WIDTH - 4, self.height - self.headerHeight - 4)];
    
    [self.moduleView setOrigin: NSMakePoint(0, self.headerHeight)];

    [self addSubview: self.moduleView];
    
    self.label = [[uiEditableTextField alloc] initWithString: self.labelText andMaxLength:14];

    [self.label setOrigin:NSMakePoint(4, 4)];
    
    [self bind:@"labelText" toObject: _label withKeyPath:@"stringValue" options:nil];
    
    [self addSubview: self.label];
    
    uiButton *removeBtn = [[uiButton alloc] initWithSize: 12 andEvent: @"removeRack"];
    [removeBtn setEventData: @{@"rackID": self.rackID}];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 16, 4)];
    [removeBtn setInEditView:YES];
    
    [self addSubview: removeBtn];
    
    [self addRackTitle];
    
    /* Mappings */
    
    self.mappings = [MIKMIDIMapping new];

    return self;
}

-(NSMutableDictionary*)data {
    return _data;
}

-(void)setData:(NSMutableDictionary *)data {
    
    self.labelText = data[@"label"];
    
    self.rackID = data[@"rackID"];
    
//    self.sendEndpoint = data[@"midiDest"];
    
    _data = data;
    
    [self updateModules];
    
}

-(void)updateModules {
    
    NSLog(@"Rack Data %@", _data);
    
    [self.moduleView emptyView];
    
    int yLoc = 0;
    
    for(int i = 0; i < [_data[@"moduleLayout"] count]; i++) {

        NSNumber *moduleID = _data[@"moduleLayout"][i];

        NSMutableDictionary *moduleData = [_data[@"modules"] objectForKey: moduleID];

        moduleBase *module = [self getModuleWithData: moduleData];

        [module setOrigin: NSMakePoint(0, yLoc)];

        module.delegate = self;

        [self.moduleView addModuleView: module];

        yLoc += module.frameHeight;
        
        NSLog(@"%d", yLoc);
        
    }

}

-(moduleBase*)getModuleWithData:(NSMutableDictionary*)moduleData {
    
    moduleBase *module;
    
    return module;
    
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
        [[global sharedGlobalData].colors[@"red"] setFill];
    } else {
        [[global sharedGlobalData].colors[@"grey"] setFill];
    }
    
    [headerPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, RACK_WIDTH, self.headerHeight) xRadius: 0 yRadius: 0];
    
    [headerPath closePath];
    [headerPath fill];
    
//    [fgPath moveToPoint:NSZeroPoint];
//    [fgPath lineToPoint:NSMakePoint(0, self.headerHeight)];
//    [fgPath lineToPoint:NSMakePoint(0, self.height)];
//    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH, self.height)];
//    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH, self.headerHeight)];
//    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH - 4, self.headerHeight)];
//    [fgPath lineToPoint:NSMakePoint(RACK_WIDTH - 4, self.height-4)];
//    [fgPath lineToPoint:NSMakePoint(4, self.height-4)];
//    [fgPath lineToPoint:NSMakePoint(4, 4)];
//    [fgPath lineToPoint:NSMakePoint(4, self.headerHeight)];
//    [fgPath lineToPoint:NSMakePoint(0, self.headerHeight)];
//    
//    [fgPath fill];
    

    
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
    self.height = newHeight - TOOLBAR_HEIGHT - TITLE_BAR_HEIGHT - 4;;
    NSRect f = self.frame;
    f.size.height = self.height;
    [self setFrame:f];
    [self setNeedsDisplay:YES];
}

-(void)midiCommand:(NSArray*)data {
    
    NSMutableArray *newData = [data mutableCopy];
    
    if([_data[@"channel"] intValue] > 0) {
        NSNumber *newStatus = [NSNumber numberWithInt: [data[0] intValue] + [_data[@"channel"] intValue] - 1 ];
        [newData replaceObjectAtIndex:0 withObject: newStatus];
    }
    
    NSLog(@"New data: %@", newData);

    if([self.midiSend selectedObject]) {
        NSError *error = nil;
        MIKMutableMIDIControlChangeCommand *command = [[MIKMutableMIDIControlChangeCommand alloc] init];
        
        [command setCommandType: [newData[0] unsignedIntegerValue]];
        [command setControllerNumber: [newData[1] unsignedIntegerValue]];
        [command setControllerValue: [newData[2] unsignedIntegerValue]];
        
        NSLog(@"command: %@", command);
        
        NSArray *commands = @[command];
        
        MIKMIDIDestinationEndpoint *endpoint = [self.midiSend selectedObject];
        
        [[MIKMIDIDeviceManager sharedDeviceManager] sendCommands: commands toEndpoint: endpoint error: &error ];
    }
}

-(void)midiData:(NSArray*)data {
    
//    if([[_midiDeviceController selectedObjects] count]) {
//        NSError *error = nil;
//        
//        NSLog(@"Status byte: %d", [utilities getMidiPacket: data]);
//
//        MIDIPacket midiPacket = [utilities getMidiPacket: data]->packet[0];
//        
//        MIKMutableMIDICommand *command = [[MIKMutableMIDICommand commandWithMIDIPacket: &midiPacket] mutableCopy];
//        
//        [command setDataByte1: midiPacket.data[1]];
//        
//        NSLog(@"command: %@", command);
//        
//        NSArray *commands = @[command];
//        
//        MIKMIDIDestinationEndpoint *endpoint = [_midiDeviceController selectedObjects][0];
//        
//        [[MIKMIDIDeviceManager sharedDeviceManager] sendCommands: commands toEndpoint: endpoint error: &error ];
//        
//        NSLog(@"Error: %@", [error localizedDescription]);
//    }

}

-(void)mouseDown:(NSEvent *)theEvent {
    [global deselectNotify];
}

-(void)startRecord:(NSString *)MIDIIdentifier {
    NSLog(@"Delegate received: %@", MIDIIdentifier);
}

@end
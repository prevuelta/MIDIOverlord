//
//  dataState.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "appModel.h"

@implementation appModel

@synthesize appData = _appData;

- (id)init {
    self = [super init];
    if(!self) return nil;

    [self setupData:[self loadDefaultState]];

    return self;
}

- (void)setupData:(NSMutableDictionary*)data{

    NSLog(@"Setting up data...");

    _appData = data;

    NSLog(@"App Data: %@", _appData);

    _global = [_appData objectForKey: @"global"];

    _state = [NSMutableDictionary dictionaryWithDictionary: _appData[@"state"]];

    _rackData = [NSMutableDictionary dictionaryWithDictionary: _state[@"rackData"]];

    _rackID = [_state objectForKey: @"rackID"];

    _rackCount = [_rackData count];

    _rackLayout = [NSMutableArray arrayWithArray:_state[@"rackLayout"]];

    // Observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateModule:) name:@"moduleUpdate" object:nil];

}

- (NSMutableDictionary*)loadDefaultState {

    NSDictionary *defaultState = @{
        @"global" :
            @{
                @"clock"  : @120,
                @"devices"  : @[]
                },
        @"state"  :
            @{
                @"rackID"   : @0,
                @"rackData" : @{},
                @"rackLayout" : @[]
            }
    };

    return [NSMutableDictionary dictionaryWithDictionary:defaultState];
}

- (int)getIntFrom:(NSDictionary*)dictionary withKey:(NSString*)key {
    return [[dictionary objectForKey: key] intValue];
}

-(NSNumber*)addRack:(NSNumber*)type {

    [global deselectNotify];

    _rackID = @([_rackID intValue] + 1);

    NSLog(@"%@", _rackID);

    switch([type intValue]) {
        case 1: // Control Rack
        break;
        case 2: // Map rack
        break;
    }

    NSMutableDictionary* rack = [@{
        @"rackID" : _rackID,
        @"label": [NSString stringWithFormat: @"RACK %@", _rackID],
        @"size": @0,
        @"channel": @1,
        @"input": @0,
        @"output": @0,
        @"moduleID" : @0,
        @"mappings":@[]
    } mutableCopy];

    [rack setObject: [NSMutableDictionary new] forKey: @"modules"];
    [rack setObject: [NSMutableArray new] forKey: @"moduleLayout"];
    [rack setObject: [NSMutableArray new] forKey: @"midiDest"];


    [_rackData setObject: rack forKey: _rackID];

    [_rackLayout addObject: _rackID];

    _rackCount = (int)[_rackLayout count];

    return _rackID;

}

-(void)removeModule:(NSDictionary*)ref {
    [_rackData[ref[@"rackID"]][@"modules"] removeObjectForKey:ref[@"moduleID"]];
    [_rackData[ref[@"rackID"]][@"moduleLayout"] removeObjectIdenticalTo:ref[@"moduleID"]];
}

-(void)removeRack:(NSDictionary*)ref {
    [_rackData removeObjectForKey:ref[@"rackID"]];
    [_rackLayout removeObject:ref[@"rackID"]];
}

-(void)addModuleOfType: (NSNumber*)type toRack: (NSNumber*)rackID {

    [global deselectNotify];

    NSLog(@"Rack data: %@", rackID);

    NSMutableDictionary* rack = [_rackData objectForKey: rackID];

    rack[@"moduleID"] = @([rack[@"moduleID"] intValue] + 1);

    NSMutableDictionary* module = [@{
        @"moduleID" : rack[@"moduleID"],
        @"rackID"   : rackID,
        @"label" : @"<label>",
        @"type" : type,
        } mutableCopy];

    switch([type intValue]) {
        case 1 : {
            module[@"noteOnStatus"] = @144;
            module[@"noteOffStatus"] = @128;
            module[@"pads"] = [NSMutableArray new];
            NSDictionary *pad = @{@"sendNoteValue": @24, @"velocity" : @127, @"receiveNoteValue" : @-1};
            for(int i = 0; i < 4; i++) {
                [module[@"pads"] addObject: [pad mutableCopy]];
            }
        } break;
        case 2 :
            module[@"min"] = @0;
            module[@"max"] = @127;
            module[@"ccStatus"] = @176;
            module[@"receiveCC"] = @-1;
            module[@"sendCC"] = @-1;
            module[@"ccValue"] = @0;
        break;
        case 3:
            module[@"receiveStatus"] = @-1;
            module[@"sendStatus"] = @-1;
        break;
    }


    [rack[@"modules"] setObject: module forKey: rack[@"moduleID"]];

    [rack[@"moduleLayout"] addObject: rack[@"moduleID"]];

     NSLog(@"Modules: %@", rack[@"modules"]);

    [_rackData setObject: rack forKey: rackID];

}

-(NSMutableDictionary*)appData {
    [_state setObject: _rackLayout forKey: @"rackLayout"];
    [_state setObject: _rackData forKey: @"rackData"];
    [_state setObject: _rackID forKey: @"rackID"];

    [_appData setObject:_state forKey: @"state"];

    return _appData;
}

-(void)setAppData:(NSMutableDictionary *)appData {
    [self setupData: appData];
}


@end

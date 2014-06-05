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
    
    
}

- (NSMutableDictionary*)loadDefaultState {
    
    NSDictionary *defaultState = @{@"global" :
                                        @{
                                            @"clock"  : @120,
                                            @"devices"  : @[]
                                            },
                                    @"state"  :
                                        @{
                                            @"title" : @"Default State",
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

-(void)addRack {

    _rackID = @([_rackID intValue] + 1);
    
    NSLog(@"%@", _rackID);
    
    NSDictionary* rackBase = @{
        @"rackID" : _rackID,
        @"label": [NSString stringWithFormat: @"RACK %@", _rackID],
        @"size": @0,
        @"channel": @0,
        @"input": @0,
        @"output": @0,
        @"moduleID" : @0
    };
    
    NSMutableDictionary *rack = [NSMutableDictionary dictionaryWithDictionary: rackBase];
    
    [rack setObject: [NSMutableDictionary new] forKey: @"modules"];
    [rack setObject: [NSMutableArray new] forKey: @"moduleLayout"];
    
    // Add rack
    [_rackData setObject: rack forKey: _rackID];
//
    [_rackLayout addObject: _rackID];
//
    _rackCount = (int)[_rackLayout count];
    
}


-(void)addModule:(NSNumber*)rackID :(NSNumber*)type; {
    
    NSLog(@"RID: %@ Type: %@", rackID, type);
    
    NSMutableDictionary* rack = [_rackData objectForKey: rackID];
    
    NSDictionary* module;

    rack[@"moduleID"] = @([rack[@"moduleID"] intValue] + 1);

    switch([type intValue]) {
        case 1 :
           module = @{
             @"label" : @"Untitled",
             @"type" : type,
             @"val" : @60
         };
        case 2 :
            module = @{
               @"label" : @"Untitled",
               @"type" : type,
               @"val" : @60,
               @"min" : @0,
               @"max" : @127
            };
        break;
    }

    NSLog(@"Modules: %@", rack[@"modules"]);
    
    [rack[@"modules"] setObject: module forKey: rack[@"moduleID"]];

    [rack[@"moduleLayout"] addObject: rack[@"moduleID"]];

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


//-(NSMutableArray*)getRackModules: (int)layoutIndex {
//    
//    NSMutableArray* modules = [NSMutableArray new];
//
//    for(id index in _layout[layoutIndex]) {
//        [modules addObject:_moduleData[index]];
    
        
//        NSMutableDictionary *module = _moduleData[index];
//        NSLog(@"Module: %@", module);
//        NSNumber *ID = [module objectForKey:@"ID"];
//        
//        NSLog(@"%@, %@", _layout[layoutIndex], ID);
//        NSLog([_layout[layoutIndex] containsObject: ID] ? @"YES" : @"NO");
        
//        if([_layout[layoutIndex] indexOfObject: ID]) {
//            [modules addObject:module];
//            NSLog(@"Done added module");
//        }
//    }

//    NSLog(@"Mdousldsd: %@", modules);
    
//    return modules;
//
//}

@end

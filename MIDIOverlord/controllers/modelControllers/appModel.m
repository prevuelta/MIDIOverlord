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
    
    _state = [NSMutableDictionary dictionaryWithDictionary: [_appData objectForKey: @"state"]];
    
    NSDictionary* page = [[_state objectForKey: @"pages"] objectAtIndex: 0];
    
    _layout = [NSMutableArray arrayWithArray: [_state objectForKey: @"layout"]];
    
    _rackData = [NSMutableArray arrayWithArray: [_state objectForKey: @"racks"]];
    
    _moduleID =  [[_state objectForKey: @"moduleID"] integerValue];
    
    _rackID = [[_state objectForKey: @"rackID"] integerValue];
    
    _moduleData = [NSMutableDictionary dictionaryWithDictionary:[_state objectForKey: @"modules"]];

    _rackCount = [_rackData count];
    
    
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
                                            @"moduleID" : @0,
                                            @"rackID"   : @0,
                                            @"layout" : @[],
                                            @"racks" : @[],
                                            @"modules" : @{}
                                        }
                                    
                                    };
    
    return [NSMutableDictionary dictionaryWithDictionary:defaultState];
}

- (int)getIntFrom:(NSDictionary*)dictionary withKey:(NSString*)key {
    return [[dictionary objectForKey: key] intValue];
}

-(void)addPage {
    NSDictionary* page = @{
      @"ID" : @1,
      @"title" : @"Untitled",
      @"layout" : [NSMutableArray new]
    };
    
    _currentPage = page;
}

-(void)addRack {

    _rackID++;
    
    NSNumber *ID = [NSNumber numberWithInteger: _rackID];
    
   [_state setObject: ID forKey: @"rackID"];
    
    NSDictionary* rack = @{
        @"ID" : ID,
        @"page" : [NSNumber numberWithInt: 0],
        @"label": [NSString stringWithFormat: @"RACK %@", ID],
        @"size": @0,
        @"channel": @0,
        @"input": @0,
        @"output": @0
    };
    
    [_rackData addObject:rack];

    // Rack layout
    NSMutableArray *newLayout = [NSMutableArray new];
    
    [_layout addObject: newLayout];
    _rackCount = [_rackData count];
    
}

-(NSMutableDictionary*)appData {
    [_state setObject:_layout forKey: @"layout"];
    [_state setObject:_rackData forKey: @"racks"];
    [_appData setObject:_state forKey: @"state"];
    return _appData;
}
-(void)setAppData:(NSMutableDictionary *)appData {
    [self setupData: appData];
}

-(NSInteger)getRackID:(int)index {
    return [[_rackData[index] objectForKey:@"ID"] integerValue];
}

-(void)addModule:(int)pageIndex :(int)rackIndex :(int)type {
    
    _moduleID = _moduleID + 1;
    
    NSDictionary* module = @{
         @"label" : @"Untitled",
         @"type" : [NSNumber numberWithInt:type],
         @"val" : @60,
         @"min" : @0,
         @"max" : @127,
         @"midiIN" : @0,
         @"midiOUT" : @24
    };
    
    [_moduleData setObject: module forKey: [NSNumber numberWithInteger: _moduleID]];
    
    [_layout[rackIndex] addObject:[NSNumber numberWithInteger: _moduleID]];
    
    NSLog(@"Layout: %@", _layout);

}

-(NSMutableArray*)getRackModules: (int)layoutIndex {
    
    NSMutableArray* modules = [NSMutableArray new];
    
    for(id index in _layout[layoutIndex]) {
        [modules addObject:_moduleData[index]];
        
        
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
    }
    
//    NSLog(@"Mdousldsd: %@", modules);
    
    return modules;

}

@end

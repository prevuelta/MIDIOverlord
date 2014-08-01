//
//  appViewController.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 2/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "appViewController.h"

@implementation appViewController

-(id)initWithWin:(NSWindow*)mainWin {
    self = [super init];
    if(!self) return nil;
    
    _data = [[appModel alloc] init];
    
    _mainView = [[appView alloc] initWithWin:mainWin];
    
    // Add observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addControlRack:) name:@"addControlRack" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeRack:) name:@"removeRack" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addModule:) name:@"addSlider" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addModule:) name:@"addPads" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeModule:) name:@"removeModule" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFile:) name:@"fileLoaded" object:nil];

    
    return self;
}


-(void)loadFile:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    [_data setupData:userInfo[@"data"]];
    
    [_mainView createRacksWithData: _data.rackData andLayout: _data.rackLayout];
    
    [_mainView resizeWin: (int)_data.rackCount];
}

-(void)addControlRack:(NSNotification*)notification  {
    [self addRack: @1];
}

-(void)addRack:(NSNumber*)type {

    NSNumber *rackID = [_data addRack: type];
    [_mainView addRackWithData: _data.rackData[rackID]];

}

-(void)removeRack:(NSNotification*)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    [_data removeRack: userInfo];
    [_mainView removeRack: userInfo[@"rackID"]];

}

-(void)addModule:(NSNotification*)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSNumber *rackID = userInfo[@"rackID"];
    
    [_data addModuleOfType: userInfo[@"type"] toRack: rackID];
    
    [_mainView updateRackModules: rackID ];
    
}

-(void)removeModule:(NSNotification*)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    [_data removeModule: userInfo];
    
    [_mainView updateRackModules: userInfo[@"rackID"] ];
    
}

//-(void)updateRackModules: (NSDictionary*)rackData {
//    [_mainView updateRackModules: rackData];
//}

@end

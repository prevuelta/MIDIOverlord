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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRack:) name:@"addRack" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addModule:) name:@"addModule" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFile:) name:@"fileLoaded" object:nil];
    
//    NSLog(@"New data: %@", [_data rackData]);
    
//    [_mainView updateRackModules:[_data getRackID:0] : [_data getRackModules:0]];
//    [_mainView updateRackModules:[_data getRackID:1] : [_data getRackModules:1]];
    
//    [_mainView updateRackModules [_data getRackModules:rackData[0]]:[data layout[0]];
    
//    [_mainView updateModules:[_data moduleData]:[_data layout]];
 
    // Set grid origins
    //    CGRect frame = mainView.frame;
    //    frame.origin = CGPointMake(_windowPadding, _windowPadding);
    //    mainView.frame = frame;
    
    return self;
}

-(void)loadFile:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    [_data setupData:userInfo[@"data"]];
    
    [self updateRacks];
    
//    NSLog(@"Rack count: %@", [NSNumber numberWithInt: _data.rackCount]);
    
    [_mainView resizeWin: _data.rackCount];
}

-(void)addRack:(NSNotification*)notification {
    
    [_data addRack];
    
    [self updateRacks];

}

-(void)addModule:(NSNotification*)notification {
    
//    NSLog(@"%@", notification);
    
    NSDictionary *userInfo = notification.userInfo;
    
    [_data addModule: userInfo[@"rackID"] : userInfo[@"type"]];
    
    [self updateRacks];
    
}

-(void)updateRacks {
    [_mainView updateRacks: _data.rackData : _data.rackLayout];
}

@end

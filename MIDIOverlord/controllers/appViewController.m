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
    
    [_data addRack: 0];
    [_data addRack: 1];
    
    [_data addModule: 0 :0 :1 ];
    [_data addModule: 0 :0 :2 ];
    [_data addModule: 1 :1 :1 ];
    [_data addModule: 1 :1 :1 ];
    [_data addModule: 1 :1 :1 ];
    [_data addModule: 1 :1 :1 ];
    
    NSLog(@"New data: %@", [_data rackData]);
    
    [_mainView updateRacks: _data.rackData :_data.layout];
    
    [_mainView updateRackModules:[_data getRackID:0] : [_data getRackModules:0]];
    [_mainView updateRackModules:[_data getRackID:1] : [_data getRackModules:1]];
    
//    [_mainView updateRackModules [_data getRackModules:rackData[0]]:[data layout[0]];
    
//    [_mainView updateModules:[_data moduleData]:[_data layout]];
    
    [_mainView resizeWin: [_data.layout count]];
    
    // Set grid origins
    //    CGRect frame = mainView.frame;
    //    frame.origin = CGPointMake(_windowPadding, _windowPadding);
    //    mainView.frame = frame;

    
    return self;
}



@end

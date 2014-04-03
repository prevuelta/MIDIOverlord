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
    
    _mainWin = mainWin;
    
    _data = [[appModel alloc] init];
    
    [_data loadDefaultState];
    
    _mainView = [[appView alloc] initWithFrame:[_mainWin frame]];
    
    [_mainView updateRacks:[_data rackData]:[_data layout]];
    
    [_mainView setRackCount: [_data rackCount]];
    
    // Set window size
    NSPoint gridSize = _mainView.getSize;
    [self resizeWin: gridSize];
    
    // Set grey background
    float greyVal = 0.70;
    NSColor *grey = [NSColor colorWithDeviceRed:greyVal green:greyVal blue:greyVal alpha: (float)1];
    _mainWin.backgroundColor = grey;
    
    // Add grid
    [_mainWin setContentView: _mainView];
    
    // Set grid origins
    //    CGRect frame = mainView.frame;
    //    frame.origin = CGPointMake(_windowPadding, _windowPadding);
    //    mainView.frame = frame;

    
    return self;
}

- (void)resizeWin:(NSPoint)size {
    
    NSRect frame = [_mainWin frame];
    
    frame.size.width = size.x;
    frame.size.height = size.y + 20;
    
    [_mainWin setFrame: frame display:YES animate:NO];
}


@end

//
//  AppDelegate.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // Setup app data
    _state = [[dataApp alloc] init];
    [_state setData:@"state"];
    
    // Add event handler
    _events = [eventHandler new];
    
    // UI
    _windowPadding = 20;
    
    viewApp *mainView = [[viewApp alloc] initWithFrame:[_mainWin frame] andData:[_state controlData] andLayout:[_state layout]];

    [mainView setRows: [_state rows]];
    [mainView setCols: [_state cols]];
    
    // Set window size
    
    NSPoint gridSize = mainView.getSize;
    [self resizeWin: gridSize];
    
    // Set grey background
    
    float greyVal = 0.70;
    NSColor *grey = [NSColor colorWithDeviceRed:greyVal green:greyVal blue:greyVal alpha: (float)1];
    _mainWin.backgroundColor = grey;
    
    // Add grid
    
    [_mainWin setContentView: mainView];
    
    // Set grid origins
    CGRect frame = mainView.frame;
    frame.origin = CGPointMake(_windowPadding, _windowPadding);
    mainView.frame = frame;
    
    
    
}

- (IBAction)makeView:(id)sender {
    NSLog(@"Making view...");

  }

- (void)resizeWin:(NSPoint)size {
    
    NSRect frame = [_mainWin frame];
    
    frame.size.width = size.x + (_windowPadding * 2);
    frame.size.height = size.y + (_windowPadding * 2) + 20;
    
    [_mainWin setFrame: frame display:YES animate:NO];
}


@end

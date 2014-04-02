//
//  AppDelegate.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // APP
    _data = [[appModel alloc] init];
    
//    [_appData setCurrentFile:@"defaultState"];
    [_data loadDefaultState];
    
    // MIDI
    _midiController = [[midiController alloc] init];

    
    // UI
//    _windowPadding = 20;
    
    viewApp *mainView = [[viewApp alloc] initWithFrame:[_mainWin frame]
    andRackData: [_appData rackData]
    andModuleData:[_appData moduleData]
    andLayout:[_appData layout]];

    [mainView setRackCount: [_appData rackCount]];
    
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
//    CGRect frame = mainView.frame;
//    frame.origin = CGPointMake(_windowPadding, _windowPadding);
//    mainView.frame = frame;

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

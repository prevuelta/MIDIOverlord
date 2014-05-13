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
//    _data = [[appModel alloc] init];
//    
//    [_data loadDefaultState];
    
    [_mainWin setHasShadow: NO];
//    [_mainWin setStyleMask: NSBorderlessWindowMask];

    _appViewControl = [[appViewController alloc] initWithWin: _mainWin];
    

    // MIDI
    _midiController = [[midiController alloc] init];


}

- (IBAction)makeView:(id)sender {
    NSLog(@"Making view...");

  }

@end

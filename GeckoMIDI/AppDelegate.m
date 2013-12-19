//
//  AppDelegate.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // Setup app data
    _state = [[dataState alloc] init];
    [_state setData:@"state"];
    
    
    // UI
    _windowPadding = 20;
    
    gmGrid *mainGrid = [[gmGrid alloc] init];
    
    // Set window size
    
    NSPoint gridSize = mainGrid.getSize;
    [self resizeWin: gridSize];
    
    // Set grey background
    
    float greyVal = 0.70;
    NSColor *grey = [NSColor colorWithDeviceRed:greyVal green:greyVal blue:greyVal alpha: (float)1];
    _mainWin.backgroundColor = grey;
    
    // Add grid view
    [_mainWin setContentView: mainGrid];
    
    // Set grid origins
    CGRect frame = mainGrid.frame;
    frame.origin = CGPointMake(_windowPadding, _windowPadding);
    mainGrid.frame = frame;
    

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

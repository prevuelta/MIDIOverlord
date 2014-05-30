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

// Document handlers

-(IBAction)openDocument:(id)sender {
        
        NSOpenPanel* openDlg = [NSOpenPanel openPanel];
        
        [openDlg setPrompt:@"Select"];
        
        // Enable the selection of files in the dialog.
        [openDlg setCanChooseFiles:YES];
        
        // Enable the selection of directories in the dialog.
        [openDlg setCanChooseDirectories:YES];
        
        NSArray* moFileTypes = [[NSArray alloc] initWithObjects:@"MOS", @"mos", @"MOM", @"mom", nil];

        [openDlg setAllowedFileTypes:moFileTypes];
    
        [openDlg runModal];
    
        _currentFile = [openDlg URL];
    
        NSLog(@"File path: %@", [_currentFile absoluteString]);
    
        NSMutableDictionary *appData = [NSKeyedUnarchiver unarchiveObjectWithFile: @"/Users/pablo/test.mos"];
        NSAssert(appData, @"unarchiveObjectWithFile failed");
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fileLoaded" object:self userInfo: @{@"data" : appData}];
}

-(IBAction)saveDocument:(id)sender {
    
    
        NSMutableDictionary *appData = [_appViewControl.data appData];
    
        BOOL success = [NSKeyedArchiver archiveRootObject: appData toFile: @"/Users/pablo/test.mos"];
        NSAssert(success, @"archiveRootObject failed");
    
}


@end

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
    [self createWindow];
    [self initApp];
    
    NSLog(@"Devices: %@", [[MIKMIDIDeviceManager sharedDeviceManager] availableDevices]);
    
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

    if ([openDlg runModal] == NSFileHandlingPanelOKButton) {
       _currentFile = [openDlg URL];
        
        NSLog(@"File path: %@", [_currentFile absoluteString]);
        
        NSMutableDictionary *appData = [NSKeyedUnarchiver unarchiveObjectWithFile: @"/Users/pablo/test.mos"];
        NSAssert(appData, @"unarchiveObjectWithFile failed");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fileLoaded" object:self userInfo: @{@"data" : appData}];
        
        if(![_mainWin isKeyWindow]) {
            
            [self createWindow];
        
        }
//        
//        [self initApp];
        
        [_appViewControl.mainView.titleBar setTitle: [[_currentFile absoluteString] lastPathComponent] ];
        
    }
}

-(void)createWindow {
    NSSize screenSize = [NSScreen mainScreen].frame.size;
    NSRect frame = NSMakeRect((screenSize.width/2)-400, (screenSize.height/2)-300, 800, 600);
    NSUInteger styleMask = NSResizableWindowMask;
    NSRect rect = [NSWindow contentRectForFrameRect:frame styleMask:styleMask];
    
    _mainWin = [[appWindow alloc] initWithContentRect:rect styleMask:styleMask backing: NSBackingStoreBuffered defer:false];
    
    [_mainWin setMinSize:NSMakeSize(800, 600)];
    
    [_mainWin makeKeyAndOrderFront: _mainWin];
}

-(void)initApp {

    
    _appViewControl = [[appViewController alloc] initWithWin: _mainWin];
    _midiController = [[midiController alloc] init];
}

-(IBAction)saveDocument:(id)sender {
    
    NSMutableDictionary *appData = [_appViewControl.data appData];

    BOOL success = [NSKeyedArchiver archiveRootObject: appData toFile: @"/Users/pablo/test.mos"];
    NSAssert(success, @"archiveRootObject failed");
    
}


@end

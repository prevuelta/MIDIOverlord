//
//  AppDelegate.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//Data
#import "appModel.h"
#import "midiController.h"
//UI
#import "appViewController.h"
#import "appWindow.h"

// Utilites

@interface AppDelegate : NSObject <NSApplicationDelegate>

//@property appModel* data;

@property appViewController *appViewControl;

@property midiController* midiController;

@property appWindow *mainWin;


// Filehandling
@property NSURL *currentFile;

-(void)initApp;

-(IBAction)openDocument:(id)sender;
-(IBAction)saveDocument:(id)sender;

@end

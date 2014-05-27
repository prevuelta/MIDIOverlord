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
#import "eventHandler.h"

// Utilites

@interface AppDelegate : NSObject <NSApplicationDelegate>

//@property appModel* data;

@property appViewController *appViewControl;

@property midiController* midiController;
@property (assign) IBOutlet NSWindow *mainWin;

@property eventHandler* events;

// Filehandling
@property NSURL *currentFile;

-(IBAction)openDocument:(id)sender;
-(IBAction)saveDocument:(id)sender;

@end

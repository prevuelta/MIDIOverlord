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

@property appModel* data;
@property midiController* midiController;
@property (assign) IBOutlet NSWindow *mainWin;
@property float windowPadding;
@property eventHandler* events;

- (IBAction)makeView:(id)sender;
- (void)resizeWin:(NSPoint)size;

@end

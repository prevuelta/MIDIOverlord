//
//  AppDelegate.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//Data
#import "dataApp.h"
#import "midiController.h"
//UI
#import "viewApp.h"
#import "eventHandler.h"

// Utilites

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property dataApp* appData;
@property midiController* midiController;
@property (assign) IBOutlet NSWindow *mainWin;
@property float windowPadding;
@property eventHandler* events;

- (IBAction)makeView:(id)sender;
- (void)resizeWin:(NSPoint)size;

@end

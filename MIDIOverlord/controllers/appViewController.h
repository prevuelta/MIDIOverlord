//
//  appViewController.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 2/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "appView.h"
#import "appModel.h"

@interface appViewController : NSViewController

@property (strong, atomic) appView *mainView;
@property (strong, atomic) appModel *data;

-(id)initWithWin:(NSWindow*)mainWin;
-(void)loadFile:(NSNotification*)notification;

-(void)addControlRack:(NSNotification*)notification;
-(void)addRack:(NSNumber*)type;

-(void)addModule:(NSNotification*)notification;
-(void)removeModule:(NSNotification*)notification;

// Update view
-(void)updateRackModules: (NSDictionary*)rackData;

@end

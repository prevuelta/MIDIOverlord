//
//  grid.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "rackControl.h"
#import "uiToolBar.h"
#import "uiTitleBar.h"
#import "global.h"

@interface appView: NSView

@property NSWindow *mainWin;

@property BOOL editMode;

@property NSMutableDictionary* racks;
@property NSMutableArray *rackLayout;

@property uiTitleBar* titleBar;
@property uiToolBar* toolBar;

-(id)initWithWin:(NSWindow*)mainWin;

-(void)resizeWin:(int)rackCount;

-(void)windowResizeHandler:(NSNotification*)notification;

-(void)drawRect:(NSRect)rect;

//-(moduleBase*)getModuleWithData:(NSMutableDictionary*)moduleData;

// Create
-(void)createRacksWithData:(NSMutableDictionary*)rackData andLayout:(NSMutableArray*)layout;
-(void)addRackWithData: (NSMutableDictionary*)rackData;

// Update
//-(void)updateRack:(NSMutableDictionary*)rackData;
-(void)updateRackModules:(NSNumber*)rackID;

// Remove
-(void)removeRack:(NSNumber*)rackID;
-(void)arrangeRacks;

@end
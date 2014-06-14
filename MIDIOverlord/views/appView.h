//
//  grid.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "rackControl.h"
#import "moduleBase.h"
#import "moduleSlider.h"
#import "modulePad.h"
#import "uiApp.h"

@interface appView: NSView

@property NSWindow *mainWin;

@property BOOL editMode;

@property NSMutableArray* racks;

-(id)initWithWin:(NSWindow*)mainWin;

-(void)resizeWinEvent:(NSNotification*)notification;
-(void)resizeWin:(int)rackCount;

-(void)drawRect:(NSRect)rect;

-(void)drawGrid;

-(void)updateRacks:(NSMutableDictionary*)rackData :(NSMutableArray*)layout;
-(moduleBase*)getModuleWithData:(NSMutableDictionary*)moduleData;


@end
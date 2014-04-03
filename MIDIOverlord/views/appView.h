//
//  grid.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "moduleRack.h"
#import "moduleBase.h"
#import "moduleSlider.h"
#import "modulePad.h"
#import "uiApp.h"

@class appView;

@protocol appViewDelegate
    -(void)addRack;
    -(void)updateRack;
    -(void)removeRack:(int)ID;
    -(void)addModule;
    -(void)updateModule;
    -(void)removeModule:(int)ID;
@end

@interface appView: NSView

@property int rackCount;

//@property NSMutableArray* layout;
@property NSMutableDictionary* modules;
@property NSDictionary* moduleData;
//@property NSMutableArray* rackData;

-(id)initWithFrame:(NSRect)frame;
//andRackData:(NSMutableArray*)rackData andModuleData:(NSDictionary*)moduleData andLayout:(NSMutableArray*)layout;
-(NSPoint)getSize;

-(void)drawRect:(NSRect)rect;

-(void)drawGrid;

-(moduleBase*)getModuleWithId:(NSString*)mID;

-(void)updateRacks:(NSDictionary*)rackData :(NSArray*)layout;

@end
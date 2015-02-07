//
//  grid.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "appView.h"

@implementation appView

- (id)initWithWin:(NSWindow*)mainWin {
    
    self = [super initWithFrame:mainWin.frame];
    
    if(!self) return nil;
    
    NSLog(@"Init main view");

    _mainWin = mainWin;

    _racks = [NSMutableDictionary new];
    
    _rackLayout = [NSMutableArray new];
    
    _titleBar = [[uiTitleBar alloc ] initWithFrame: NSMakeRect(4, 4, self.frame.size.width - 8, TITLE_BAR_HEIGHT )];
    
    [self addSubview:_titleBar];
    
    _toolBar = [[uiToolBar alloc ] initWithFrame: NSMakeRect(0, 0, self.frame.size.width - 8, TOOLBAR_HEIGHT )];
    
    [_toolBar setOrigin:NSMakePoint(4, TITLE_BAR_HEIGHT + 4)];
    
    [self addSubview:_toolBar];

//    _mainWin.backgroundColor = grey;
//    _mainWin.backgroundColor = [global sharedGlobalData].colors[@"darkBrown"];

    
     // Add grid
    [_mainWin setContentView: self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEditMode:) name:@"editMode" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowResizeHandler:) name:NSWindowDidResizeNotification object: nil];
    
    return self;
}

-(void)windowResizeHandler:(NSNotification*)notification {
    
    NSLog(@"Window resize: %@", notification);
    NSWindow *win = notification.object;

    [_titleBar resizeWidth: win.frame.size.width - 8];
    [_toolBar resizeWidth: win.frame.size.width - 8];
}

-(void)updateRackModules:(NSNumber*)rackID {
    [_racks[rackID] updateModules];
}

-(void)removeRack:(NSNumber*)rackID {

    [_racks[rackID] removeFromSuperview];

    [_racks removeObjectForKey:rackID];
    [_rackLayout removeObject: rackID];
    [self arrangeRacks];
}

-(void)arrangeRacks {
    
    int xLoc = 4;
    
    NSLog(@"Racks %@ and Layout: %@", _racks, _rackLayout);
    
    for(NSString *rackID in _rackLayout) {
        
        rackBase* rack = [_racks objectForKey: rackID];
        
        [rack setOriginWithX: xLoc andY: TOOLBAR_HEIGHT + 12 + TITLE_BAR_HEIGHT];
        
        [rack setNeedsDisplay: YES];
    
        xLoc += [rack getWidth] + 2;
    }
    
}

/* Add rack */

-(void)addRackWithData:(NSMutableDictionary *)rackData {
    
    NSNumber *rackID = rackData[@"rackID"];
    
    int rackWidth = [global getUnitWidth: [rackData[@"unitWidth"] intValue]];
    
    rackControl *rack = [[rackControl alloc] initWithFrame: NSMakeRect(0, 0, rackWidth, _mainWin.frame.size.height) andData: rackData];
    
    [rack setOrigin:NSMakePoint([_racks count] * (rackWidth + 2) + 4, TOOLBAR_HEIGHT + 12 + TITLE_BAR_HEIGHT)];
    
    [_racks setObject: rack forKey: rackID];
    
    [_rackLayout addObject: rackID];
    
    [self addSubview:rack];
    
}

-(void)createRacksWithData:(NSMutableDictionary*)rackData andLayout:(NSMutableArray*)layout {
    
    for(rackBase *rack in _racks) {
        [rack removeFromSuperview];
    }
    
    _racks = [NSMutableDictionary new];
    
    for(int rI = 0; rI < [layout count]; rI++) {
        
        NSNumber *rackID = layout[rI];
        
        NSMutableDictionary *data = [rackData objectForKey: rackID];
        
        int rackWidth = [global getUnitWidth: [data[@"unitWidth"] intValue]];
        
        // Create rack
        rackControl *rack = [[rackControl alloc] initWithFrame: NSMakeRect(0, 0, rackWidth, _mainWin.frame.size.height) andData: data];
        
        [rack setOrigin:NSMakePoint(rI * (rackWidth + 2) + 4, TOOLBAR_HEIGHT + 12 + TITLE_BAR_HEIGHT)];
        
        [_racks setObject: rack forKey: rackID];
        
        [self addSubview:rack];
        
    }
    
    [self resizeWin: [layout count]];
}


-(void)drawRect:(NSRect)rect {
    
    [[global sharedGlobalData].colors[@"black"] setFill];
    NSRectFill(rect);
}

-(BOOL)isFlipped {
    return YES;
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"Mainview clicked");
    [global deselectNotify];
}

-(void)handleEditMode:(NSNotification*)notification {
   self.editMode = [notification.userInfo[@"isToggled"] boolValue];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

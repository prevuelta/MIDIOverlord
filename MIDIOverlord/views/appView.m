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
    
    [_toolBar setOrigin:NSMakePoint(4, TITLE_BAR_HEIGHT + 8)];
    
    [self addSubview:_toolBar];

    // Set grey background
    float greyVal = 0.70;
    NSColor *grey = [NSColor colorWithDeviceRed:greyVal green:greyVal blue:greyVal alpha: (float)1];
    _mainWin.backgroundColor = grey;
     
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
    
    int xLoc = 2;
    
    NSLog(@"Racks %@ and Layout: %@", _racks, _rackLayout);
    
    for(NSString *rackID in _rackLayout) {
        
        rackBase* rack = [_racks objectForKey: rackID];
        
        [rack setOriginWithX: xLoc andY: TOOLBAR_HEIGHT + 2 + TITLE_BAR_HEIGHT];
        
        [rack setNeedsDisplay: YES];
    
        xLoc += RACK_WIDTH + 2;
    }
    
}

/**
 *  Add Rack
 */

-(void)addRackWithData:(NSMutableDictionary *)rackData {
    
    NSNumber *rackID = rackData[@"rackID"];
    
    rackControl *rack = [[rackControl alloc] initWithFrame: NSMakeRect(0, 0, RACK_WIDTH, _mainWin.frame.size.height) andData: rackData];
    
    [rack setOrigin:NSMakePoint([_racks count] * (RACK_WIDTH + 2) + 4, TOOLBAR_HEIGHT + 12 + TITLE_BAR_HEIGHT)];
    
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
        
        // Create rack
        rackControl *rack = [[rackControl alloc] initWithFrame: NSMakeRect(0, 0, RACK_WIDTH, _mainWin.frame.size.height) andData: data];
        
        [rack setOrigin:NSMakePoint(rI * (RACK_WIDTH + 2) + 4, TOOLBAR_HEIGHT + 12 + TITLE_BAR_HEIGHT)];
        
        [_racks setObject: rack forKey: rackID];
        
        [self addSubview:rack];
        
    }
    
    [self resizeWin: [layout count]];
}


-(void)drawRect:(NSRect)rect {
//    [[NSColor colorWithPatternImage: [global sharedGlobalData].patternBg] set];
    
    [[global sharedGlobalData].colors[@"white"] setFill];
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

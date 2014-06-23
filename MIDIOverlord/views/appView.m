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

    _racks = [NSMutableArray new];

    // Setup main interface
    _globalUI = [[uiApp alloc ] initWithFrame: NSMakeRect(0, 0, self.frame.size.width, TOOLBAR_HEIGHT )];
    [self addSubview:_globalUI];
    
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
//    int height = notification.object.Size.height;
    NSLog(@"Window resize: %@", notification);
    NSWindow *win = notification.object;

    [_globalUI resizeWidth: win.frame.size.width];
}

-(void)resizeWin:(int)rackCount {
    
//    NSRect frame = [_mainWin frame];
//    
//    frame.size.width = RACK_WIDTH * rackCount;
//    frame.size.height = WINDOW_HEIGHT + TOOLBAR_HEIGHT + 22;
//    
//    NSLog(@"Frame height: %@, %@", [NSNumber numberWithInt:frame.size.height], [NSNumber numberWithInt:rackCount]);
//    
//    [_mainWin setFrame:frame display:NO animate:NO];
    
}

-(void)updateRacks:(NSMutableDictionary*)rackData :(NSMutableArray*)layout {
    
//    NSLog(@"%@", layout);
    for(rackBase *rack in _racks) {
        [rack removeFromSuperview];
    }
    
    _racks = [NSMutableArray new];
    
    for(int rI = 0; rI < [layout count]; rI++) {
        
        NSNumber *rackID = layout[rI];
        
//        NSLog(@"Layout: %@", layout[rI]);
        
        NSMutableDictionary *data = [rackData objectForKey: rackID];
        
        NSMutableArray *moduleLayout = [data objectForKey: @"moduleLayout"];
        
        // Create rack
        rackControl *rack = [[rackControl alloc] initWithFrame: NSMakeRect(0, 0, RACK_WIDTH, _mainWin.frame.size.height)andData: data];
        
        [rack setOrigin:NSMakePoint(rI * (RACK_WIDTH + 4) + 4, TOOLBAR_HEIGHT + 4)];
        
        int yLoc = 0;
        
        for(int mI = 0; mI < [data[@"moduleLayout"] count]; mI++) {
            
//            NSLog(@"Updating modules");
            
            NSNumber *moduleID = data[@"moduleLayout"][mI];
            
            NSMutableDictionary *moduleData = [data[@"modules"] objectForKey: moduleID];
            
//            NSLog(@"Module data:%@", moduleData);
            
            moduleBase *module = [self getModuleWithData: moduleData];
            
            [module setEditMode: _editMode];
            
            [module setOrigin: NSMakePoint(0, yLoc)];
            
            module.delegate = rack;
            
            [rack.moduleView addModuleView: module];
            
            yLoc += module.height;
            
//            NSLog(@"Height: %@", [NSNumber numberWithInt: yLoc]);
            
        }
        
        [self addSubview:rack];
        [self.racks addObject: rack];
        
    }
    
    [self resizeWin: [layout count]];
}
                   
-(moduleBase*)getModuleWithData:(NSMutableDictionary*)moduleData{
    
    moduleBase *module;

    switch([moduleData[@"type"] intValue]) {
        case 1: {
            module = [[modulePad alloc] initWithData: moduleData];
//            NSLog(@"added pad");
        } break;
        case 2: {
            module = [[moduleSlider alloc] initWithData: moduleData];
//            NSLog(@"added slider");
        } break;
    }
    
    return module;
    
}

-(void)drawRect:(NSRect)rect {
    [[NSColor colorWithPatternImage: [global sharedGlobalData].patternBg] set];
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

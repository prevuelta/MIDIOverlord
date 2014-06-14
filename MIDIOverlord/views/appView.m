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
    
    self = [super initWithFrame:[mainWin frame]];
    
    if(!self) return nil;
    
    NSLog(@"Init main view");

    
    _mainWin = mainWin;

    _racks = [NSMutableArray new];

    // Setup main interface
    uiApp* globalUI = [[uiApp alloc ] initWithFrame: NSMakeRect(0, 0, RACK_WIDTH * 4, TOOLBAR_HEIGHT )];
    [self addSubview:globalUI];
    
    // Set grey background
    float greyVal = 0.70;
    NSColor *grey = [NSColor colorWithDeviceRed:greyVal green:greyVal blue:greyVal alpha: (float)1];
    _mainWin.backgroundColor = grey;
     
     // Add grid
    [_mainWin setContentView: self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEditMode:) name:@"editMode" object:nil];
    
    return self;
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
        
        [rack setOrigin:NSMakePoint(rI * RACK_WIDTH, TOOLBAR_HEIGHT)];
        
        int yLoc = rack.headerHeight;
        
        for(int mI = 0; mI < [data[@"moduleLayout"] count]; mI++) {
            
//            NSLog(@"Updating modules");
            
            NSNumber *moduleID = data[@"moduleLayout"][mI];
            
            NSMutableDictionary *moduleData = [data[@"modules"] objectForKey: moduleID];
            
//            NSLog(@"Module data:%@", moduleData);
            
            moduleBase *module = [self getModuleWithData: moduleData];
            
            [module setEditMode: _editMode];
            
            [module setOrigin: NSMakePoint(4, yLoc)];
            
            module.delegate = rack;
            
            [rack addSubview: module];
            
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
//    [self drawGrid];
//    [self drawmodules];
}

//-(void)drawGrid{
//    
//    NSRect frame = self.frame;
//
////    NSLog(@"Drawing grid...");
//    
//    // Draw border & bg
//    NSPoint bgSize = self.getSize;
//    
//    // Draw Grid
//    NSBezierPath* path = [NSBezierPath bezierPath];
//    [path setLineWidth: 0.5];
//    
//    int i = 0;
//    
//    while(i <= _rackCount) {
//
////        NSLog(@"go %i cols: %i", i, _cols);
//        NSPoint colOrigin = {0.5, i * RACK_HEIGHT + 0.5};
//        NSPoint colDestination = {WINDOW_WIDTH, i * RACK_HEIGHT + 0.5};
//
//        [path moveToPoint: colOrigin ];
//        [path lineToPoint: colDestination ];
//        
//        i++;
//        
//    }
//
//    // Translate
//    NSAffineTransform *translateTransform = [NSAffineTransform transform];
//    [translateTransform translateXBy: 0 yBy:0];
//    [path transformUsingAffineTransform: translateTransform];
//    
//    [path closePath];
//    [[NSColor blackColor] set];
//    [path stroke];
//    
//}

-(BOOL)isFlipped {
    return YES;
}

-(void)mouseDown:(NSEvent *)theEvent {
//    NSLog(@"Mainview clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
}

-(void)handleEditMode:(NSNotification*)notification {
   self.editMode = [notification.userInfo[@"isToggled"] boolValue];
}

@end

//
//  grid.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "appView.h"

int _xLoc;

@implementation appView

- (id)initWithWin:(NSWindow*)mainWin {
    
//}andRackData:(NSMutableArray*)rackData andModuleData:(NSDictionary*)moduleData andLayout:(NSMutableArray*)layout {
    self = [super initWithFrame:[mainWin frame]];
    
    if(!self) return nil;
    
    NSLog(@"Init main view");
    
    _mainWin = mainWin;

//    _layout = layout;
//
//    _rackCount = (int) [_layout count];

//    NSLog(@"Rack count: %d", _rackCount);

//    _moduleData = moduleData;

//    _rackData = rackData;

    // Setup main interface
    uiApp* globalUI = [[uiApp alloc ] initWithFrame: NSMakeRect(0, 0, WINDOW_WIDTH, TOOLBAR_HEIGHT )];

    [self addSubview:globalUI];
    
    // Set grey background
    float greyVal = 0.70;
    NSColor *grey = [NSColor colorWithDeviceRed:greyVal green:greyVal blue:greyVal alpha: (float)1];
    _mainWin.backgroundColor = grey;
     
     // Add grid
    [_mainWin setContentView: self];
    
    return self;
}


-(void)resizeWin:(NSInteger)rackCount{
    
    NSRect frame = [_mainWin frame];
    
    frame.size.width = WINDOW_WIDTH;
    frame.size.height = (RACK_HEIGHT * rackCount) + TOOLBAR_HEIGHT + 22;
    
    NSLog(@"Frame height: %@", [NSNumber numberWithInt:frame.size.height]);
    
    [_mainWin setFrame:frame display:NO animate:NO];
    
}

-(void)updateRacks:(NSMutableArray*)rackData :(NSMutableArray*)layout {
    
    for(int row = 0; row < [layout count]; row++) {
        
        // Create rack
        moduleRack *rack = [[moduleRack alloc] initWithFrame: NSMakeRect(0, 0, WINDOW_WIDTH, RACK_HEIGHT)];
        
        
        [rack setOrigin:NSMakePoint(0, (row * RACK_HEIGHT) + TOOLBAR_HEIGHT)];
        
        [rack setData: rackData[row]];
        
        NSInteger rackID = [[rackData[row] objectForKey:@"ID"] integerValue];
        
        [rack setTag: rackID];
        
        [self addSubview:rack];
        
    }
}

-(void)updateRackModules:(NSInteger)rackID :(NSMutableArray*)moduleData {
  
        NSLog(@"Updating module: %@", moduleData);
    
        moduleRack *rack = [self viewWithTag: rackID];
    
        _xLoc = rack.headerWidth;
    
        NSLog(@"RACK: %@", rack);
    
        for(int i = 0; i < [moduleData count]; i++) {
            
            NSLog(@"Updating modul");
            
            NSInteger type = [[moduleData[i] objectForKey:@"type"] integerValue];
            
            moduleBase *module = [self getModuleOfType:type];
            
            [module setData: moduleData[i]];
            
            [module setOrigin: NSMakePoint(_xLoc, RACK_HEIGHT - MODULE_HEIGHT)];
            
            _xLoc += module.width;
            
            module.delegate = rack;
//            
            [rack addSubview: module];
        }
    
//        [rack setSubviews: rack.subViews];
    
        [rack setNeedsDisplay:YES];
}
                            
-(moduleBase*)getModuleOfType:(NSInteger)type {
    
    moduleBase *module;

    switch(type) {
        case 1: {
            module = [[modulePad alloc] initWithFrame];
            NSLog(@"added pad");
        } break;
        case 2: {
            module = [[moduleSlider alloc] initWithFrame];
            NSLog(@"added slider");
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
    NSLog(@"Mainview clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
}

@end

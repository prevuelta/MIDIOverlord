//
//  grid.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "appView.h"

int _yLoc;

@implementation appView

- (id)initWithWin:(NSWindow*)mainWin {
    
    self = [super initWithFrame:[mainWin frame]];
    
    if(!self) return nil;
    
    NSLog(@"Init main view");
    
    _mainWin = mainWin;


    // Setup main interface
    uiApp* globalUI = [[uiApp alloc ] initWithFrame: NSMakeRect(0, 0, RACK_WIDTH * 4, TOOLBAR_HEIGHT )];
    [self addSubview:globalUI];
    
    // Set grey background
    float greyVal = 0.70;
    NSColor *grey = [NSColor colorWithDeviceRed:greyVal green:greyVal blue:greyVal alpha: (float)1];
    _mainWin.backgroundColor = grey;
     
     // Add grid
    [_mainWin setContentView: self];
    
    return self;
}


-(void)resizeWin:(int)rackCount {
    
    NSRect frame = [_mainWin frame];
    
    frame.size.width = RACK_WIDTH * rackCount;
    frame.size.height = WINDOW_HEIGHT + TOOLBAR_HEIGHT + 22;
    
    NSLog(@"Frame height: %@, %@", [NSNumber numberWithInt:frame.size.height], [NSNumber numberWithInt:rackCount]);
    
    [_mainWin setFrame:frame display:NO animate:NO];
    
}

-(void)updateRacks:(NSMutableArray*)rackData :(NSMutableArray*)layout {
    
    NSLog(@"%@", layout);
    
    for(int row = 0; row < [layout count]; row++) {
        
        // Create rack
        rackControl *rack = [[rackControl alloc] initWithFrame: NSMakeRect(0, 0, RACK_WIDTH * 4, WINDOW_HEIGHT)];
        
        [rack setOrigin:NSMakePoint(row * RACK_WIDTH, TOOLBAR_HEIGHT)];
        
        [rack setData: rackData[row]];
        
        NSInteger rackID = [[rackData[row] objectForKey:@"ID"] integerValue];
        
        [rack setTag: rackID];
        
        [self addSubview:rack];
        
    }
}

-(void)updateRackModules:(NSInteger)rackID :(NSMutableArray*)moduleData {
  
        NSLog(@"Updating module: %@", moduleData);
    
        rackControl *rack = [self viewWithTag: rackID];
    
        _yLoc = rack.headerHeight;
    
        NSLog(@"RACK: %@", rack);
    
        for(int i = 0; i < [moduleData count]; i++) {
            
            NSLog(@"Updating modul");
            
            NSInteger type = [[moduleData[i] objectForKey:@"type"] integerValue];
            
            moduleBase *module = [self getModuleOfType:type];
            
            [module setData: moduleData[i]];
            
            [module setOrigin: NSMakePoint(0, _yLoc)];
            
            _yLoc += module.height;
            
            module.delegate = rack;
           
            [rack addSubview: module];
        }

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

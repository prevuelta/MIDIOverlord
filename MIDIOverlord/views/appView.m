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

- (id)initWithFrame:(NSRect)frame {
    
//}andRackData:(NSMutableArray*)rackData andModuleData:(NSDictionary*)moduleData andLayout:(NSMutableArray*)layout {
    self = [super initWithFrame:frame];
    
    if(!self) return nil;
    
    NSLog(@"Init main view");

//    _layout = layout;
//
//    _rackCount = (int) [_layout count];

//    NSLog(@"Rack count: %d", _rackCount);

//    _moduleData = moduleData;

//    _rackData = rackData;

    // Setup main interface
    uiApp* globalUI = [[uiApp alloc ] initWithFrame: NSMakeRect(0, _rackCount * RACK_HEIGHT, WINDOW_WIDTH , TOOLBAR_HEIGHT )];

    [self addSubview:globalUI];


    // Create app view

//    for(int row = 0; row < _rackCount; row++) {
//        
//        // Create rack
//        moduleRack *rack = [[moduleRack alloc] initWithFrame: NSMakeRect(0, 0, WINDOW_WIDTH, RACK_HEIGHT)];
//        
//        [rack setOrigin:NSMakePoint(0, row * RACK_HEIGHT)];
//        
//        [rack setData: _rackData[row]];
//        
//        _xLoc = 0;
//        
        // Add modules to rack
//        for(int col = 0; col < [_layout[row] count]; col++) {
//
//            NSString* mID = [_layout[row][col] stringValue];
//            
//            moduleBase *module = [self getModuleWithId: mID];
//            
//            [module setOrigin: NSMakePoint(_xLoc + 0.5, 0)];
//            
//            NSLog(@"Module: %d", _xLoc);
    
//            [rack addSubview: module];
            
            
            
            // Add data
    //                [_modules setObject: module forKey: mID];
            
//            _xLoc += module.width;
    
    //                if(mID) {
    //                    NSString* mIDStr = (NSString*)mID;
    ////                    NSLog(@"%@", [_moduleData objectForKey: mIDStr]);
    //                    if([_moduleData objectForKey: mID]) {
    ////                        [self addModuleWithId: mID andRow: row andCol: col];
    //                    }
//    //                }
//        }/
    
//        [self addSubview: rack];
    
//    }
    
    return self;
}

-(void)updateRacks:(NSMutableArray*)rackData :(NSArray*)layout {

    for(int row = 0; row < [layout count]; row++) {
        
        // Create rack
        moduleRack *rack = [[moduleRack alloc] initWithFrame: NSMakeRect(0, 0, WINDOW_WIDTH, RACK_HEIGHT)];
        
        [rack setOrigin:NSMakePoint(0, row * RACK_HEIGHT)];
        
        [rack setData: rackData[row]];
        
        [self addSubview: rack];

    }
}

- (NSPoint)getSize {
    NSPoint size = {
        WINDOW_WIDTH,
        (RACK_HEIGHT * _rackCount ) + TOOLBAR_HEIGHT
    };
    return size;
}
                            
-(moduleBase*)getModuleWithId:(NSString*)mID {
    
    NSDictionary* moduleData = [_moduleData objectForKey: mID];
    int type = [[moduleData objectForKey: @"type"] intValue];
    
    moduleBase *module;

    switch(type) {
        case 0: {
            module = [[modulePad alloc] initWithFrame];
        } break;
        case 1: {
            module = [[moduleSlider alloc] initWithFrame];
        } break;
    }
    
    return module;
    
}

-(void)drawRect:(NSRect)rect {
    [self drawGrid];
//    [self drawmodules];
}

-(void)drawGrid{
    
    NSRect frame = self.frame;

//    NSLog(@"Drawing grid...");
    
    // Draw border & bg
    NSPoint bgSize = self.getSize;
    
    // Draw Grid
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path setLineWidth: 0.5];
    
    int i = 0;
    
    while(i <= _rackCount) {

//        NSLog(@"go %i cols: %i", i, _cols);
        NSPoint colOrigin = {0.5, i * RACK_HEIGHT + 0.5};
        NSPoint colDestination = {WINDOW_WIDTH, i * RACK_HEIGHT + 0.5};

        [path moveToPoint: colOrigin ];
        [path lineToPoint: colDestination ];
        
        i++;
        
    }

    // Translate
    NSAffineTransform *translateTransform = [NSAffineTransform transform];
    [translateTransform translateXBy: 0 yBy:0];
    [path transformUsingAffineTransform: translateTransform];
    
    [path closePath];
    [[NSColor blackColor] set];
    [path stroke];
    
}



@end

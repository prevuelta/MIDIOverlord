//
//  grid.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "viewApp.h"

int _xLoc;

@implementation viewApp

- (id)initWithFrame:(NSRect)frame andRackData:(NSMutableArray*)rackData andModuleData:(NSDictionary*)moduleData andLayout:(NSMutableArray*)layout {
    self = [super initWithFrame:frame];
    
    if(self) {
    
        NSLog(@"Init main view");
        
        _rackCount = 0;
        
        _layout = layout;
        
        _moduleData = moduleData;
        
        _rackData = rackData;
        
        int rackCount = (int) [_layout count];
        
        // Setup main interface
        uiApp* globalUI = [[uiApp alloc ] initWithFrame: frame];
        
        [globalUI setOrigin: NSMakePoint(0, rackCount * RACK_HEIGHT)];
        
        [self addSubview:globalUI];
        
        
        // Create app view
        
        for(int row = 0; row < rackCount; row++) {
            
            NSLog(@"rows");
            [self addRackTitle: _rackData[row]];
            
            for(int col = 0; col < [_layout[row] count]; col++) {
    
                NSString* mID = [_layout[row][col] stringValue];
                
                if(mID) {
                    NSString* mIDStr = (NSString*)mID;
//                    NSLog(@"%@", [_moduleData objectForKey: mIDStr]);
                    if([_moduleData objectForKey: mID]) {
                        [self addModuleWithId: mID andRow: row andCol: col];
                    }
                }
            }
            _xLoc = 0;
        }
    }
    
    return self;
}

- (NSPoint)getSize {
    NSPoint size = {
        1024,
        (RACK_HEIGHT * _rackCount ) + TOOLBAR_HEIGHT
    };
    return size;
}

-(void)addRackTitle:(NSDictionary*)rackData {
    
}

-(void)addModuleWithId:(NSString*)mID andRow:(int)row andCol:(int)col {
    NSDictionary* moduleData = [_moduleData objectForKey: mID];
    int type = [[moduleData objectForKey: @"type"] intValue];
    
    NSLog(@"%i", type);
    
    moduleBase *module;
    
    switch(type) {
        case 0: {
            module = [[modulePad alloc] initWithFrame];
            
            // Set x y location
            
            NSLog(@"Adding pad object at x:%i", _xLoc);
        } break;
        case 1: {
            
            module = [[moduleSlider alloc] initWithFrame];
            
            NSLog(@"Adding slider object");
        } break;
    }
    
    CGFloat yLoc = (row-- * RACK_HEIGHT);
    
    [module setOrigin: NSMakePoint(_xLoc + 0.5, yLoc + 0.5)];
    
    [self addSubview:module];
    
    [_modules setObject: module forKey: mID];
    
    _xLoc += module.width;
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
        NSPoint colDestination = {1024, i * RACK_HEIGHT + 0.5};

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

//
//  grid.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "viewApp.h"
#import "uiButton.h"
#import "controlPad.h"
#import "uiGlobal.h"

int _xLoc;

@implementation viewApp

- (id)initWithFrame:(NSRect)frame andData:(NSDictionary*)controlData andLayout:(NSMutableArray*)layout {
    self = [super initWithFrame:frame];
    
    if(self) {
    
        NSLog(@"Init main view");
        
        _racks = 2;
        
//        _controls = [NSMutableDictionary new];
        _layout = layout;
        _controlData = controlData;
        
        int rackCount = (int) [_layout count];
        
        // Setup main interface
        uiGlobal* globalUI = [[uiGlobal alloc ] initWithFrame: frame];
        
        [globalUI setOrigin: NSMakePoint(0, rackCount * RACK_HEIGHT)];
        
        [self addSubview:globalUI];
        
        // Create control objects
        
        for(int row = 0; row < rackCount; row++) {
            
            NSLog(@"rows");
            
            for(int col = 0; col < [_layout[row] count]; col++) {
    
                int cID = (int)[_layout[row][col] integerValue];
                
                if(cID) {
                    NSString* cID = _layout[row][col];
                    [self addControlWithId: cID andRow: row andCol: col];

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
        ( RACK_HEIGHT * _racks ) + TOOLBAR_HEIGHT
    };
    return size;
}

-(void)addControlWithId:(NSString*)cID andRow:(int)row andCol:(int)col {
    NSDictionary* control = [_controlData objectForKey: cID];
    int type = [[control objectForKey: @"type"] intValue];
    
    switch(type) {
        case 0: {
            controlPad* cPad = [[controlPad alloc] initWithFrame];
            
            // Set x y location
            
            CGFloat yLoc = (row-- * RACK_HEIGHT);
            
            NSLog(@"%f %f", _xLoc, yLoc);
            
            [cPad setOrigin: NSMakePoint(_xLoc + 0.5, yLoc + 0.5)];
            
            [self addSubview:cPad];
            
            [_controls setObject: cPad forKey: cID];
            
            _xLoc += cPad.width;
            

            NSLog(@"Adding pad object at x:%i", _xLoc);
        } break;
    }
}

-(void)drawRect:(NSRect)rect {
    [self drawGrid];
//    [self drawControls];
}

-(void)drawGrid{
    
    NSRect frame = self.frame;

//    NSLog(@"Drawing grid...");
    
    // Draw border & bg
    NSPoint bgSize = self.getSize;
    
//    NSBezierPath* bgPath = [NSBezierPath bezierPath];
//    
//    NSPoint bgPoints[] = {0, 0, 0, bgSize.y, bgSize.x, bgSize.y, bgSize.x, 0};
//    
//    [bgPath moveToPoint:bgPoints[0]];
//    [bgPath lineToPoint: bgPoints[1]];
//    [bgPath lineToPoint: bgPoints[2]];
//    [bgPath lineToPoint: bgPoints[3]];
//    
//    [bgPath closePath];
    
    // Set fill
//    [[NSColor whiteColor] set];
//    [bgPath fill];
    
    // Draw Grid
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path setLineWidth: 0.5];
    
    int i = 0;
    
    while(i <= _racks) {

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

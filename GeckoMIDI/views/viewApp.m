//
//  grid.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "viewApp.h"
#import "uiButton.h"
#import "controlPad.h"

@implementation viewApp

@synthesize controls = _controls;

- (id)initWithFrame:(NSRect)frame andData:(NSArray*)controlData {
    self = [super initWithFrame:frame];
    
    if(self) {
    
        NSLog(@"Init main view");
        
        _colWidth = 120;
        _rowHeight = 120;
        _uiHeight = 36;
        _uiWidth = 36;
        
        _rows = 2;
        _cols = 1;    
        
        _controls = [NSMutableArray new];
        
        controlPad* cPad = [[controlPad alloc] initWithFrame:self.frame];
    //    //    [cPad setFrame:[super frame]];
        [self addSubview:cPad];

        // Create control objects
        for(int i = 0; i < [controlData count]; i++) {
            //        NSLog(@"%@", controlData);
            
            int type = [[[controlData objectAtIndex:i] objectForKey:@"type"] intValue];
            NSLog(@"Type:%i", type);
            switch(type) {
                case 0:
                    // Draw Pad
                   [_controls addObject:[[controlPad alloc] initWithFrame:self.frame]];
                    
                    NSLog(@"Adding pad object");
                    break;
            }
        }
        
        
        for(int i = 0; i < [_controls count]; i++) {
            NSView* view = [_controls objectAtIndex:i];
            [self addSubview:view];
        
        }
    }
    
    return self;
}

- (NSPoint)getSize {
    NSPoint size = {
       ((_colWidth * _cols) + _uiWidth),
       ((_rowHeight * _rows) + _uiHeight)
    };
//    NSLog(@"x: %f, y: %f", size.x, size.y);
    return size;
}

-(void)setControls:(NSArray *)controlData {
    
}

- (NSMutableArray*) controls {
    return _controls;
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
    
    NSBezierPath* bgPath = [NSBezierPath bezierPath];
    
    NSPoint bgPoints[] = {0, 0, 0, bgSize.y, bgSize.x, bgSize.y, bgSize.x, 0};
    
    [bgPath moveToPoint:bgPoints[0]];
    [bgPath lineToPoint: bgPoints[1]];
    [bgPath lineToPoint: bgPoints[2]];
    [bgPath lineToPoint: bgPoints[3]];
    
    [bgPath closePath];
    
    // Set fill
//    [[NSColor whiteColor] set];
//    [bgPath fill];
    
    // Draw Grid
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path setLineWidth: 0.5];
    
    // UI Elements
    
    NSPoint colUIOffset = {((bgSize.x-_uiWidth)/2) - (_uiWidth/2), 0};
    uiButton* colUI = [[uiButton alloc] initWithFrame:frame:_uiWidth:colUIOffset];
    
    NSPoint rowUIOffset = {bgSize.x-_uiWidth, ((bgSize.y-_uiHeight)/2) + (_uiHeight/2)};
    uiButton* rowUI = [[uiButton alloc] initWithFrame:frame:_uiWidth:rowUIOffset];
    
    int i = 0;
    
    while(i <= _cols) {
        int i2 = 0;
//        NSLog(@"go %i cols: %i", i, _cols);
        NSPoint colOrigin = {i * _colWidth + 0.5, 0.5};
        NSPoint colDestination = {i * _colWidth + 0.5, _rows * _rowHeight + 0.5};

        [path moveToPoint: colOrigin ];
        [path lineToPoint: colDestination ];
        
        // Draw Row Lines
        while(i2 <= _rows) {
            // Draw Column lines
            NSPoint origin = { 0.5 , i2 * _rowHeight + 0.5};
            NSPoint destination = {_cols * _colWidth + 0.5, i2 * _rowHeight + 0.5};
            [path moveToPoint: origin ];
            [path lineToPoint: destination ];
            i2++;
        }
        i++;
        
    }

    // Translate
    NSAffineTransform *translateTransform = [NSAffineTransform transform];
    [translateTransform translateXBy: 0 yBy:_uiHeight];
    [path transformUsingAffineTransform: translateTransform];
    
    [path closePath];
    [[NSColor blackColor] set];
    [path stroke];
    
}



@end

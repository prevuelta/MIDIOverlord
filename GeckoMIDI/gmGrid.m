//
//  grid.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "gmGrid.h"
#import "gmSlider.h"

int cols = 4;
int rows = 2;

@implementation gmGrid

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    
    _colWidth = 100;
    _rowHeight = 200;
    _uiHeight = 40;
    _uiWidth = 40;
    
//    self.setBackgroundj([NSColor whiteColor]);
    NSLog(@"initGMGrid");

    return self;
}

- (NSPoint)getSize {
    NSPoint size = {
       (float) ( (_colWidth * cols) + _uiWidth),
       (float) ( (_rowHeight * rows) + _uiHeight)
    };
    return size;
}

- (void)drawRect:(NSRect)frame {
    
    NSLog(@"Drawing grid...");
    
//    [[NSColor redColor] set];
    
//
    
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
    [[NSColor whiteColor] set];
    [bgPath fill];
    
    // Draw Grid
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path setLineWidth: 0.5];
    
    // Set line dash
    float lineDash[2] = {4, 6};
    [path setLineDash:lineDash count:2 phase: 0.0];
    
    int i = 0;
    
    while(i <= cols) {
        int i2 = 0;
        
        NSPoint colOrigin = {i * _colWidth + 0.5, 0.5};
        NSPoint colDestination = {i * _colWidth + 0.5, rows * _rowHeight + 0.5};

        [path moveToPoint: colOrigin ];
        [path lineToPoint: colDestination ];
        
        // Draw Row Lines
        while(i2 <= rows) {
            // Draw Column lines
            NSPoint origin = { 0.5 , i2 * _rowHeight + 0.5};
            NSPoint destination = {cols * _colWidth + 0.5, i2 * _rowHeight + 0.5};
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

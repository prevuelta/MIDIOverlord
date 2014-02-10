//
//  grid.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface viewApp : NSView

@property int racks;

@property NSMutableArray* layout;
@property NSMutableDictionary* controls;
@property NSDictionary* controlData;

-(id)initWithFrame:(NSRect)frame andData:(NSArray*)controlData andLayout:(NSMutableArray*)layout;
-(NSPoint)getSize;
-(void)drawRect:(NSRect)rect;
-(void)drawGrid;
-(void)addControlWithId:(NSString*)cID andRow:(int)row andCol:(int)col;

@end
//
//  grid.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "controlTrigger.h"
#import "modulePad.h"
#import "uiApp.h"
#import "moduleSlider.h"

@interface viewApp : NSView

@property int racks;

@property NSMutableArray* layout;
@property NSMutableDictionary* modules;
@property NSDictionary* moduleData;

-(id)initWithFrame:(NSRect)frame andData:(NSDictionary*)moduleData andLayout:(NSMutableArray*)layout;
-(NSPoint)getSize;
-(void)drawRect:(NSRect)rect;
-(void)drawGrid;
-(void)addModuleWithId:(NSString*)mID andRow:(int)row andCol:(int)col;

@end
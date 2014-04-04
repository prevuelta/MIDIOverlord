//
//  dataState.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appModel : NSObject

@property NSString* title;
@property NSMutableDictionary* global;
@property NSMutableDictionary* state;

@property NSString* currentFile;
@property NSDictionary* currentPage;

// Data object

@property int moduleID;
@property int rackID;

@property NSMutableDictionary* appData;
@property NSMutableDictionary* moduleData;
@property NSMutableArray* rackData;
@property NSMutableArray* layout;


-(id)init;
-(void)setupData;

-(NSMutableDictionary*)loadState:(NSString*)path;
-(NSMutableDictionary*)loadDefaultState;

-(void)openFile;
-(void)saveFile;

// Public function
-(void)addRack:(int)pageIndex;
-(void)addModule:(int)pageIndex :(int)rackIndex :(int)type;

-(NSMutableArray*)getRackModules: (int)layoutIndex;

-(NSString*)getRackID:(int)index;

@end

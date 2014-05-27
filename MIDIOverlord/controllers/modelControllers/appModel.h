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
@property NSMutableDictionary* appData;
@property NSMutableDictionary* moduleData;
@property NSMutableArray* rackData;
@property NSMutableArray* layout;

@property NSString* currentFile;
@property NSDictionary* currentPage;

// MidiData
@property NSMutableArray* midiSources;
@property NSMutableArray* midiDestinations;

// Data object
@property NSInteger moduleID;
@property NSInteger rackID;

@property int rackCount;

-(id)init;
-(void)setupData:(NSMutableDictionary*)data;

-(NSMutableDictionary*)loadDefaultState;

// Public function
-(void)addRack;
-(void)addModule:(int)pageIndex :(int)rackIndex :(int)type;

-(NSMutableArray*)getRackModules: (int)layoutIndex;

-(NSInteger)getRackID:(int)index;


@end

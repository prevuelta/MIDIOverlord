//
//  dataState.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "global.h"

@interface appModel : NSObject

@property NSString* title;

@property NSMutableDictionary* global;
@property NSMutableDictionary* state;
@property NSMutableDictionary* appData;

@property NSMutableDictionary* rackData;
@property NSMutableArray* rackLayout;

@property NSString* currentFile;
@property NSDictionary* currentPage;

// MidiData
@property NSMutableArray* midiSources;
@property NSMutableArray* midiDestinations;

// Data object
@property NSNumber* rackID;

@property NSInteger rackCount;

-(id)init;
-(void)setupData:(NSMutableDictionary*)data;

-(NSMutableDictionary*)loadDefaultState;

// Public function
-(void)addRack:(NSNumber*)type;
-(void)removeRack:(NSDictionary*)ref;
-(void)addModule:(NSNumber*)rackID :(NSNumber*)type;
-(void)removeModule:(NSDictionary*)ref;

// Update functions
-(void)updateModule:(NSNotification*)notification;

@end

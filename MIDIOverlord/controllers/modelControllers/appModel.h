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

@property int rackCount;

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



@end

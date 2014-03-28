//
//  dataState.h
//  operatorMIDI
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataApp : NSObject

@property NSString* title;
@property NSMutableDictionary* global;
@property NSMutableDictionary* state;

@property NSString* currentFile;
@property NSDictionary* currentPage;

// Data object

@property int rackCount;

@property NSMutableDictionary* appData;
@property NSMutableDictionary* moduleData;
@property NSMutableArray* layout;
@property NSMutableArray* rackData;

-(id)init;
-(void)setupData;

-(void)newJSON;
-(NSMutableDictionary*)loadJSON:(NSString*)path;
-(void)saveJSON;



@end

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
@property NSDictionary* global;
@property NSDictionary* state;

// Data object

@property int rackCount;

@property NSDictionary* moduleData;
@property NSMutableArray* moduleObjects;
@property NSMutableArray* layout;
@property NSMutableArray* rackData;

- (id)init;
- (NSDictionary*)loadFile:(NSString*)path;
- (void)setData:(NSString*)path;

@end

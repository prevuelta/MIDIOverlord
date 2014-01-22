//
//  dataState.h
//  GeckoMIDI
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

@property int cols;
@property int rows;

@property NSMutableDictionary* controls;

- (id)init;
- (NSDictionary*)loadFile;
- (void)setData:(NSString*)path;

@end

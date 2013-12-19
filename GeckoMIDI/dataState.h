//
//  dataState.h
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataState : NSObject

@property NSString* title;
@property NSDictionary* layout;

- (id)init;
-(NSDictionary*)loadFile;
- (void)setData:(NSString*)path;

@end

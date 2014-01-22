//
//  dataState.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "dataApp.h"

@implementation dataApp

- (id)init {
    self = [super init];
    
    return self;
}

- (void)setData:(NSString*)path {
     NSDictionary* appData = [self loadFile:path];
    
    _global = [appData objectForKey: @"global"];
    _state = [appData objectForKey: @"state"];
    
    NSMutableDictionary* block = [_state objectForKey: @"block"];
    
    _cols = [self getInt:block:@"cols"];
    _rows = [self getInt:block:@"rows"];
    
    _controls = [_state objectForKey: @"controls"];
}

- (NSMutableDictionary*)loadFile:(NSString*)path {
    // Load json file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSStringEncoding encoding = NSUTF8StringEncoding;
    NSData * jsonData = [jsonString dataUsingEncoding:encoding];
    NSError * error=nil;
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
}

- (int)getInt:(NSDictionary*)dictionary:(NSString*)key {
    return [[dictionary objectForKey: key] intValue];
}

@end

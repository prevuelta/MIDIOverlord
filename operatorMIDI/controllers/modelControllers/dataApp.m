//
//  dataState.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "dataApp.h"
#import "modulePad.h"

@implementation dataApp

- (id)init {
    self = [super init];
    
    return self;
}

- (void)setData:(NSString*)path {
    
    NSLog(@"Setting up data...");
    
     NSDictionary* appData = [self loadFile:path];
    
    _global = [appData objectForKey: @"global"];
    _state = [appData objectForKey: @"state"];
    
//    _moduleObjects = [[NSMutableArray alloc ] init];
    
    NSDictionary* page = [_state objectForKey: @"page"];
    
    _layout = [page objectForKey: @"layout"];
    _rackData = [page objectForKey: @"racks"];
    
//    NSLog(@"%@", _layout);
    
    _rackCount = (int)[_layout count];
    
    _moduleData = [_state objectForKey: @"controls"];
    
//    NSLog(@"%@", [_controlObjects description]);

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

- (int)getIntFrom:(NSDictionary*)dictionary withKey:(NSString*)key {
    return [[dictionary objectForKey: key] intValue];
}


@end

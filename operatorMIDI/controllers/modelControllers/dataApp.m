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
    
//    _appData = [NSMutableDictionary* alloc];
    
    return self;
}

- (void)setupData{
    
    NSLog(@"Setting up data...");
    
    _appData = [NSMutableDictionary dictionaryWithDictionary: [self loadJSON: _currentFile]];
    
//    _appData = [NSMutableDictionary objec [self loadJSON: _currentFile], nil];
    
    _global = [_appData objectForKey: @"global"];
    
    _state = [NSMutableDictionary dictionaryWithDictionary: [_appData objectForKey: @"state"]];
    
    NSDictionary* page = [[_state objectForKey: @"pages"] objectAtIndex: 0];
    
    _layout = [page objectForKey: @"layout"];
    
    _rackData = [NSMutableArray arrayWithObjects: [page objectForKey: @"racks"], nil];
    
    _rackCount = (int)[_layout count];
    
    _moduleData = [_state objectForKey: @"controls"];
    
//    NSLog(@"%@", [_controlObjects description]);
    
    [self addRack];
    
    [self saveJSON];

}

-(void)newJSON {
    
}

- (NSMutableDictionary*)loadJSON:(NSString*)path {
    // Load json file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSStringEncoding encoding = NSUTF8StringEncoding;
    NSData * jsonData = [jsonString dataUsingEncoding:encoding];
    NSError * error=nil;
    
    return (NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
}

- (int)getIntFrom:(NSDictionary*)dictionary withKey:(NSString*)key {
    return [[dictionary objectForKey: key] intValue];
}

-(void)saveJSON {
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization
        dataWithJSONObject: _appData
        options:NSJSONWritingPrettyPrinted
        error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON output: %@", jsonString);
    [jsonString writeToFile: _currentFile atomically: YES encoding:NSUTF8StringEncoding error:nil];
}

-(void)addPage {
    NSDictionary* page = @{
      @"id" : @1,
      @"title" : @"Untitled",
      @"layout" : [NSMutableArray new]
    };
    
    _currentPage = page;
}

-(void)addRack {
    NSDictionary* rack = @{
        @"id" : @1,
        @"page" : @1,
        @"label": @"Rack 1",
        @"size": @0,
        @"channel": @0,
        @"input": @0,
        @"output": @0
    };
    
    
    
    [_rackData addObject:rack];

    [_state setObject:_rackData forKey: @"racks"];
    
    [_appData setObject:_rackData forKey: @"state"];
    
    NSLog(@"Appdata: %@", _appData);
    
    [self saveJSON];
}


@end

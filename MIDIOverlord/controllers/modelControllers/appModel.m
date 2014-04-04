//
//  dataState.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "appModel.h"
#import "modulePad.h"

@implementation appModel

- (id)init {
    self = [super init];
    
    [self setupData];
    
    return self;
}

- (void)setupData{
    
    NSLog(@"Setting up data...");
    
    _appData = [NSMutableDictionary dictionaryWithDictionary: [self loadDefaultState]];
    
//    _appData = [NSMutableDictionary objec [self loadJSON: _currentFile], nil];
    
    NSLog(@"App Data: %@", _appData);
    
    _global = [_appData objectForKey: @"global"];
    
    _state = [NSMutableDictionary dictionaryWithDictionary: [_appData objectForKey: @"state"]];
    
    NSDictionary* page = [[_state objectForKey: @"pages"] objectAtIndex: 0];
    
    _layout = [NSMutableArray arrayWithObjects: [page objectForKey: @"layout"], nil];
    
    _rackData = [NSMutableArray arrayWithObjects: [page objectForKey: @"racks"], nil];
    
    _moduleData = [NSMutableDictionary dictionaryWithDictionary:[_state objectForKey: @"modules"]];
    
//    NSLog(@"%@", [_controlObjects description]);


}

-(void)saveFile {
    [_state setObject:_rackData forKey: @"racks"];
    
    [_appData setObject:_state forKey: @"state"];
    
    NSLog(@"Appdata: %@", _appData);
    
    [self saveJSON];
}

//-(NSMutableDictionary)loadState:(NSString*)path {
//    
//}

- (NSMutableDictionary*)loadDefaultState {
    
    // Load json file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"defaultState" ofType:@"json"];
    
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
    
    if(!_currentFile) {
        _currentFile = [utilities getSaveFileUrl];
    }
    
    [jsonString writeToFile: _currentFile atomically: YES encoding:NSUTF8StringEncoding error:nil];
}

-(void)addPage {
    NSDictionary* page = @{
      @"ID" : @1,
      @"title" : @"Untitled",
      @"layout" : [NSMutableArray new]
    };
    
    _currentPage = page;
}

-(void)addRack:(int)pageIndex {

    _rackID++;
    
    NSDictionary* rack = @{
        @"ID" : [NSNumber numberWithInt:_rackID],
        @"page" : [NSNumber numberWithInt:pageIndex],
        @"label": @"Rack 1",
        @"size": @0,
        @"channel": @0,
        @"input": @0,
        @"output": @0
    };
    
    [_rackData addObject:rack];

    NSMutableArray *newLayout = [[NSMutableArray alloc] init];
    
    [_layout addObject: newLayout];
    
}

-(NSString*)getRackID:(int)index {
    return [_rackData[index] objectForKey:@"ID"];
}

-(void)addModule:(int)pageIndex :(int)rackIndex :(int)type {
    
    _moduleID++;
    
    NSDictionary* module = @{
         @"label" : @"Untitled",
         @"type" : @1,
         @"val" : @60,
         @"min" : @0,
         @"max" : @127,
         @"midiIN" : @0,
         @"midiOUT" : @24
    };
    
    [_moduleData setObject: module forKey: [NSNumber numberWithInt: _moduleID]];
    
    [_layout[rackIndex] addObject:[NSNumber numberWithInt: _moduleID]];
    
    NSLog(@"Layout %@", _layout);
    NSLog(@"Layout %@", _moduleData);
}

-(NSMutableArray*)getRackModules: (int)layoutIndex {
    
    NSMutableArray* modules = [NSMutableArray new];
    
    for(NSMutableDictionary* module in _moduleData) {
        NSString* ID = [module objectForKey:@"ID"];
        if([_layout[layoutIndex] containsObject: ID]) {
            [modules addObject:[module objectForKey:ID]];
        }
    }
             
    return modules;

}

@end

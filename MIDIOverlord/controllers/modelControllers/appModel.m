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
    
    _layout = [NSMutableArray arrayWithArray: [page objectForKey: @"layout"]];
    
    _rackData = [NSMutableArray arrayWithArray: [page objectForKey: @"racks"]];
    
    _moduleID =  [[_state objectForKey: @"moduleID"] integerValue];
    
    _rackID = [[_state objectForKey: @"rackID"] integerValue];
    
    _moduleData = [NSMutableDictionary dictionaryWithDictionary:[_state objectForKey: @"modules"]];

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
    NSError * error = nil;
    
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
    
    NSNumber *ID = [NSNumber numberWithInteger:_rackID];
    
    NSDictionary* rack = @{
        @"ID" : ID,
        @"page" : [NSNumber numberWithInt:pageIndex],
        @"label": [NSString stringWithFormat: @"Rack %@", ID],
        @"size": @0,
        @"channel": @0,
        @"input": @0,
        @"output": @0
    };
    
    [_rackData addObject:rack];

    NSMutableArray *newLayout = [NSMutableArray new];
    
    [_layout addObject: newLayout];
    
}

-(NSInteger)getRackID:(int)index {
    return [[_rackData[index] objectForKey:@"ID"] integerValue];
}

-(void)addModule:(int)pageIndex :(int)rackIndex :(int)type {
    
    _moduleID = _moduleID + 1;
    
    NSDictionary* module = @{
         @"label" : @"Untitled",
         @"type" : [NSNumber numberWithInt:type],
         @"val" : @60,
         @"min" : @0,
         @"max" : @127,
         @"midiIN" : @0,
         @"midiOUT" : @24
    };
    
    [_moduleData setObject: module forKey: [NSNumber numberWithInteger: _moduleID]];
    
//    NSLog(@"Layout: %@", _layout);
    
    [_layout[rackIndex] addObject:[NSNumber numberWithInteger: _moduleID]];
    
    NSLog(@"Layout: %@", _layout);
//    NSLog(@"M DTA: %@", _moduleData);
}

-(NSMutableArray*)getRackModules: (int)layoutIndex {
    
    NSMutableArray* modules = [NSMutableArray new];
    
    for(id index in _layout[layoutIndex]) {
        [modules addObject:_moduleData[index]];
        
        
//        NSMutableDictionary *module = _moduleData[index];
//        NSLog(@"Module: %@", module);
//        NSNumber *ID = [module objectForKey:@"ID"];
//        
//        NSLog(@"%@, %@", _layout[layoutIndex], ID);
//        NSLog([_layout[layoutIndex] containsObject: ID] ? @"YES" : @"NO");
        
//        if([_layout[layoutIndex] indexOfObject: ID]) {
//            [modules addObject:module];
//            NSLog(@"Done added module");
//        }
    }
    
//    NSLog(@"Mdousldsd: %@", modules);
    
    return modules;

}

@end

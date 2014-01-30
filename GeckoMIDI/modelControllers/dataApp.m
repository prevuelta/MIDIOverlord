//
//  dataState.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 19/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "dataApp.h"
#import "controlPad.h"

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
    
    _controlObjects = [[NSMutableArray alloc ] init];
    
    NSDictionary* block = [_state objectForKey: @"block"];
    
    _layout = [block objectForKey: @"layout"];
    
//    NSLog(@"%@", _layout);
    
    _cols = (int)[_layout[0] count];
    _rows = (int)[_layout count];
    
    _controlData = [_state objectForKey: @"controls"];
    
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

//- (NSArray*)getLocation:(int)controlId {
//    NSArray loc[2];
//    int x;
//    for(int i = 0; i < [_layout count]; i++) {
//        x = Array.indexOf(_layout[i], id);
//        if(x){
//            break;
//        }
//    }
//    loc[0] = x;
//    loc[1] = i;
//    return
//}

@end

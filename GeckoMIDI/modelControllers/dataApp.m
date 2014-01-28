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
     NSDictionary* appData = [self loadFile:path];
    
    
    _global = [appData objectForKey: @"global"];
    _state = [appData objectForKey: @"state"];
    
    _controlObjects = [[NSMutableArray alloc ] init];
    
    NSDictionary* block = [_state objectForKey: @"block"];
    
    _cols = [self getInt:block:@"cols"];
    _rows = [self getInt:block:@"rows"];
    
    _controlData = [_state objectForKey: @"controls"];
    
//    // Create control objects
//    for(int i = 0; i < [_controlData count]; i++) {
//        NSLog(@"%@", _controlData);
//        
//        int type = [[[_controlData objectAtIndex:i] objectForKey:@"type"] intValue];
//        NSLog(@"Type:%i", type);
//        switch(type) {
//            case 0:
//                // Draw Pad
//                [_controlObjects addObject:[controlPad new]];
//                NSLog(@"Adding pad object");
//            break;
//        }
//    }
    
    NSLog(@"%@", [_controlObjects description]);

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

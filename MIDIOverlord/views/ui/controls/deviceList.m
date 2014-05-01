//
//  deviceList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "deviceList.h"

@implementation deviceList

-(void)addOptions {
    NSLog(@"Options data: %@", self.optionData);
    
    NSArray *extraOptions = @[@"None", @"0", @"All", @"1"];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, 4)];
    
    [self.optionData insertObjects: extraOptions atIndexes:indexSet];

    NSLog(@"Options data: %@", self.optionData);
}

//-(void)updateOptions {
//    
//}

@end

//
//  deviceList.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 14/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "deviceList.h"

@implementation deviceList

-(void)addOptions:(NSArray*)newOptions {
    
    NSLog(@"Updating options...");
    
    self.optionData = [NSMutableArray new];
    
    NSArray *extraOptions = @[@"None", @"0"];
    
    NSIndexSet *extraIndexSet = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, 2)];
    [self.optionData insertObjects: extraOptions atIndexes: extraIndexSet];

    NSIndexSet *newIndexSet = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, [newOptions count])];
    [self.optionData insertObjects: newOptions atIndexes: newIndexSet];
    
    [self updateValues];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
    
}

//-(void)updateOptions {
//    
//}

@end

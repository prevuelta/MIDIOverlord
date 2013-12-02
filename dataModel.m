//
//  dataModel.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 2/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "dataModel.h"

@implementation dataModel

- (id) init {
    NSLog(@"initing");
    [self setData];
    return self;
    
}

- (void) setData {
   self.data = @[@"Mercedes-Benz", @"BMW", @"Porsche", @"Opel", @"Volkswagen", @"Audi"];
}

- (NSArray *) getData {
    return self.data;
}
    
@end
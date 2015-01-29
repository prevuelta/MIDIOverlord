//
//  moduleMap.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 5/08/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "moduleMap.h"

@implementation moduleMap

-(id)initWithData:(NSMutableDictionary*)data {
    
    int height = 26;
    
    self = [super initWithHeight: height andUnitSize: data[@"unitSize"]];
    
    if(!self) return nil;
    
    NSLog(@"Init map module");
    
    self.height = height;
    self.flipped = YES;
    self.width = [global getUnitWidth: 2];
    
    controlList *mappingReceive = [[controlList alloc] initWithContent: @[]];
    
    [mappingReceive setOriginWithX: 4 andY: 4];
    
    controlList *mappingSend = [[controlList alloc] initWithContent: @[]];
    
    [mappingSend setOriginWithX: self.width - mappingSend.frameWidth - 4 andY: 4];
    
    [self addSubview: mappingReceive];
    [self addSubview: mappingSend];
    
    return self;
}

@end

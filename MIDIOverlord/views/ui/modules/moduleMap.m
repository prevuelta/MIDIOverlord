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
    
    self = [super initWithUnitWidth:data[@"unitWidth"] andUnitHeight: data[@"unitHeight"]];
    
    if(!self) return nil;
    
    NSLog(@"Init map module");
    
    self.height = [self getHeight];
    self.flipped = YES;
    self.width = [self getWidth];
    
    self.data = data;
    
    controlList *mappingReceive = [[controlList alloc] initWithContent: @[]];
    
    [mappingReceive setOriginWithX: 4 andY: 4];
    
    controlList *mappingSend = [[controlList alloc] initWithContent: @[]];
    
    [mappingSend setOriginWithX: self.width - mappingSend.frameWidth - 4 andY: 4];
    
    [self addSubview: mappingReceive];
    [self addSubview: mappingSend];
    
    return self;
}

@end

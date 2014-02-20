//
//  controlClass.m
//  operatorMIDI
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlClass.h"

@implementation controlClass

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    return self;
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

//-(void)mouseDown:(NSEvent *)theEvent {
//    NSLog(@"Clicked");
//    [self notify];
//   
//}


-(void)setControlLabel:(NSString*)text {
    self.label = [[NSTextField alloc] initWithFrame:NSMakeRect(64, 20, 0, 0)];
    [self.label setEditable:false];
    [self.label setStringValue: text];
    [self addSubview: self.label];
    
}

- (void)sendTrigger:(int)type :(int)value {;
    NSDictionary* data = @{@"note": [NSNumber numberWithInt:value]};
    [utilities notifyWithData:type:data];
}


@end

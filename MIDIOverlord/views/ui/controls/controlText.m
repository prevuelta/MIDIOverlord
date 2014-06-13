//
//  controlText.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 11/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "controlText.h"

@implementation controlText

- (id)initWithString: (NSString*)stringValue {
    NSRect frame = NSMakeRect(0, 0, 40, 24);
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _stringValue = stringValue;
    
    _label = [[uiText alloc] initWithString: stringValue];
    
    [self addSubview: _label];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

//-(int)value {
//    return _value;
//}
//
//-(void)setValue: (int)value {
//    if(value >= 0 && value <= _max) {
//        _value = value;
//        [self setNeedsDisplay:YES];
//    }
//}

-(void)mouseDown:(NSEvent *)e {
//    if(self.editable) {
//        NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
////        baseY = location.y;
//        [self setActive: YES];
//    }
}

- (void)mouseDragged:(NSEvent*)e {
    if(self.active){
        NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
        NSLog(@"%@", [NSNumber numberWithInt: location.y ]);
        //        int newValue = location.y > baseY ? _value + 1 : _value - 1;/
//        int newValue = _value + (location.y - baseY);
//        NSLog(@"%@", [NSNumber numberWithInt:_value]);
//        [self setValue: newValue];
//        baseY = location.y;
    }
}

-(void)mouseUp:(NSEvent *)e {
//    if(self.editable) {
//        self.active = false;
//    }
}


@end

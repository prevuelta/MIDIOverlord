//
//  gmUIElement.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "controlPad.h"

@implementation controlPad

@synthesize noteValue = _noteValue;
@synthesize velocity = _velocity;

-(id)initWithSize:(NSPoint)size andNoteValue: (NSNumber*)noteValue andVelocity: (NSNumber *)velocity {
    
    _size = size;
    _min = 0;
    _max = 127;
    _range = _max;
    _velocity = velocity;
    
    _padNote = [[controlText alloc] initWithLabel: @"|" andValue: noteValue];
    
    self = [super initWithFrame:NSMakeRect(0, 0, size.x, size.y + _padNote.frameHeight + 2)];
    if(!self) return nil;
    
    [_padNote setOrigin:NSMakePoint(0, 41)];
    
    [self bind:@"noteValue" toObject:_padNote withKeyPath:@"value" options:nil];
    
    _noteLabel = [[uiTextField alloc] initWithString: @"---" andMaxLength: 5 ];
    _velocityLabel = [[uiTextField alloc] initWithString: [_velocity stringValue] andMaxLength: 3 ];
    
    [_noteLabel setOriginWithX: 0 andY: 4];
    [_velocityLabel setOriginWithX: 0 andY: 20];
    
    [_noteLabel setDrawBg: NO];
    [_velocityLabel setDrawBg: NO];
    
    [self addSubview: _padNote];
    
    [self addSubview: _noteLabel];
    [self addSubview: _velocityLabel];
    
    [self updateMarker];

    [self setNoteValue: noteValue];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    
    NSBezierPath* btnPath = [NSBezierPath new];
    NSBezierPath* markerPath = [NSBezierPath new];
    
    [btnPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, _size.x, _size.y) xRadius: 1 yRadius: 1];
    [markerPath appendBezierPathWithRoundedRect:NSMakeRect(0, 0, _size.x, _marker) xRadius: 1 yRadius: 1];
    
    if(self.active) {
        [[global sharedGlobalData].activeColor set];
    } else {
        [[global sharedGlobalData].bgColor set];
    }
    
    [btnPath fill];
    
    [[global sharedGlobalData].markerColor set];
    
    [markerPath fill];
}

-(NSNumber*)noteValue {
    return _noteValue;
}

-(void)setNoteValue:(NSNumber*)noteValue {
    _noteValue = noteValue;
    [_noteLabel setStringValue: [utilities noteName: [_noteValue intValue]]];
}

-(void)mouseDown:(NSEvent *)theEvent {
//    [self.padNote.valueNumberField setStringFromValue];
    self.active = YES;
    [self setNeedsDisplay:YES];
}

-(void)mouseDragged:(NSEvent*)e {
    NSLog(@"Dragged");
    if(self.active){
        [self updateControlFromEvent:e];
    }
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.active = NO;
    [self setNeedsDisplay:YES];
}

-(NSNumber*)velocity{
    return _velocity;
}

-(void)setVelocity:(NSNumber *)velocity{
    _velocity = velocity;
    [self updateMarker];
    [self.velocityLabel setStringValue:[_velocity stringValue]];
}

-(void)updateMarker {
    float percent = [_velocity floatValue] / (float) self.range;
    NSLog(@"Slider value: %@ Percent: %f", _velocity, percent);
    int newValue = floor(_size.y * percent);
    [self setMarker: newValue];
}

-(void)updateControlFromData:(NSNumber*)value {
    [self setValue: value];
}

-(void)updateControlFromEvent:(NSEvent*)e {
    
    NSPoint location = [self convertPoint:[e locationInWindow] fromView:nil];
    
    float percent = location.y / _size.y;
    int newValue =  percent < 0 ? _min : percent > 1 ? _max : floor(_range * percent);
    
    [self setVelocity: [NSNumber numberWithInt: newValue]];
    
    [self setNeedsDisplay:YES];
    
}


@end

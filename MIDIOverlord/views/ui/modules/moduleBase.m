//
//  moduleBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@implementation moduleBase

@synthesize labelText = _labelText;
@synthesize tag = _tag;
@synthesize data = _data;

@synthesize midiV3 = _midiV3;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselect:) name:@"deselectAll" object:nil];
    
    
    controlText *midiValueText = [[controlText alloc] initWithFrame: _midiV1 andLabel: @"CC"];
    
    [midiValueText setOrigin:NSMakePoint(0, MODULE_HEIGHT - 16)];
    
    [midiValueText setEditable:YES];
    
    [self bind:@"midiV2" toObject:midiValueText withKeyPath:@"value" options:nil];
    
    [self addSubview:midiValueText];

    self.height = MODULE_HEIGHT;
    
    float bgRGBA[] = UI_COLOR_PROT_1;
    float selectedRGBA[] = UI_COLOR_HIGHLIGHT;
    
    self.bgColor = [utilities getNSColorFromRGB: bgRGBA];
    self.selectedColor = [utilities getNSColorFromRGB: selectedRGBA];
    
    _selected = NO;
    
    self.labelText = @"UNTITLED";
    
    return self;
}

-(void)deselect:(NSNotification*)notification  {
    _selected = NO;
    [self setNeedsDisplay:YES];
}

-(void)setOrigin:(NSPoint)origin {
    NSRect f = self.frame;
    f.origin = origin;
    [self setFrame:f];
}

-(NSDictionary*)data {
    return _data;
}

-(void)setData:(NSDictionary*)data {
    _data = data;
}

-(void)mouseDown:(NSEvent *)theEvent {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
    _selected = YES;
    [self setNeedsDisplay:YES];
}

// Event handlers
-(void)uiEvent:(char*)type {
//    [self uiEvent:type withInt:0];
}

//-(void)uiEvent:(char*)type withInt:(int)value {
////    NSLog(@"Ui event with int: %d", value);
//    
//    if(strncmp(type, "noteOn", 6) == 0) {
//        NSLog(@"Note on trigger");
//        
////        [utilities midiNotification: 0x90 : self.midiValue : 127 ];
//    }
//    if(strncmp(type, "noteOff", 6) == 0) {
//        NSLog(@"Note off trigger");
////        [utilities midiNotification: 0x80 : self.midiValue : 127 ];
//    }
//    if(strncmp(type, "sliderVal", 9) == 0) {
//        [self.delegate midiData: @[@"0xB0", [NSNumber numberWithInt: self.midiValue], [NSNumber numberWithInt: value]]];
//    }
//}

-(void)drawRect:(NSRect)rect {
    [self drawModule:rect];
    [self drawBg:rect];
}

-(NSInteger)tag {
    return _tag;
}

-(void)setTag:(NSInteger)tag {
    _tag = tag;
}

-(void)drawModule:(NSRect)rect {
    // Overwritten
}

-(void)drawBg:(NSRect)rect {
    
    // Draw background
    
    NSBezierPath* bgPath = [NSBezierPath new];
    
    if(_selected) {
         [self.selectedColor set];
    } else {
        [self.bgColor set];
    }
    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];
    
    
//    NSLog(@"Drawing");
}

-(NSString*)labelText {
    return _labelText;
}

-(void)setLabelText:(NSString*)labelText {
//    [self.label setStringValue: labelText];
//    [self.label setNeedsDisplay:YES];
    _labelText = labelText;
}

-(int)midiV3 {
    return _midiV3;
}

-(void)setMidiV3:(int)midiV3 {
//    NSLog(@"Set midiv2 %@", [NSNumber numberWithInt:midiV2]);
    [self.delegate midiData: @[[NSNumber numberWithInt: self.midiV1], [NSNumber numberWithInt: self.midiV2], [NSNumber numberWithInt: self.midiV3]]];
    _midiV3 = midiV3;
}

@end

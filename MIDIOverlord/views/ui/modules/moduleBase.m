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

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    controlText *midiValueText = [[controlText alloc] initWithFrame:NSMakeRect(8, 96, 48, 20): _midiValue];
    
    [midiValueText bind:@"value" toObject:self withKeyPath:@"self.midiValue" options:nil];
    
    [self addSubview:midiValueText];

    self.height = MODULE_HEIGHT;
    
    float bgRGBA[] = UI_COLOR_PROT_1;
    float selectedRGBA[] = UI_COLOR_HIGHLIGHT;
    
    self.bgColor = [utilities getNSColorFromRGB: bgRGBA];
    self.selectedColor = [utilities getNSColorFromRGB: selectedRGBA];
    
    _selected = NO;
    
    self.labelText = @"Untitled";
    
    return self;
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
   _selected = !_selected;
    NSLog(@"CLIKE");
    [self setNeedsDisplay:YES];
}

// Event handlers
-(void)uiEvent:(char*)type {
    [self uiEvent:type withInt:0];
}

-(void)uiEvent:(char*)type withInt:(int)value {
    NSLog(@"Ui event with int: %d", value);
    
    if(strncmp(type, "noteOn", 6) == 0) {
        NSLog(@"Note on trigger");
        [utilities midiNotification: 0x90 : self.midiValue : 127 ];
    }
    if(strncmp(type, "noteOff", 6) == 0) {
        NSLog(@"Note off trigger");
        [utilities midiNotification: 0x80 : self.midiValue : 127 ];
    }
    if(strncmp(type, "sliderVal", 9) == 0) {
        [utilities midiNotification: 0xB0 : self.midiValue :value];
    }
}

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
    
    
    NSLog(@"Drawing");
}

-(NSString*)labelText {
    return _labelText;
}

-(void)setLabelText:(NSString*)labelText {
    [self.label setStringValue: labelText];
    [self.label setNeedsDisplay:YES];
    _labelText = labelText;
}

-(BOOL)isFlipped {
    return YES;
}

@end

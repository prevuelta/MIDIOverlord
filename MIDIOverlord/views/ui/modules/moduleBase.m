//
//  moduleBase.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "moduleBase.h"

@implementation moduleBase

@synthesize tag = _tag;
@synthesize data = _data;
@synthesize editMode = _editMode;

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.width = RACK_WIDTH - 8 - SCROLLER_WIDTH;
    
    self.selected = NO;
    self.editMode = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEditMode:) name:@"editMode" object:nil];
    
    return self;
}

-(NSMutableDictionary*)data {
    return _data;
}

-(void)setData:(NSMutableDictionary*)data {
    NSLog(@"setting data");
    _data = data;
}

-(void)mouseDown:(NSEvent *)theEvent {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOpen" object:self userInfo: nil];
//    self.selected = YES;
//    [self setNeedsDisplay:YES];
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
    
    if(self.selected) {
         [[global sharedGlobalData].defaultColor set];
    } else {
        [[global sharedGlobalData].blackColor set];
    }

    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];

}

-(void)handleEditMode:(NSNotification*)notification {
    NSNumber *editMode = notification.userInfo[@"isToggled"];
    [self setEditMode: [editMode boolValue]];

}

-(BOOL)editMode{
    return _editMode;
}

-(void)setEditMode:(BOOL)editMode {
    for(id control in self.subviews) {
        BOOL hide = [control inEditView] == editMode ? NO : YES;
        [control setHidden: hide];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

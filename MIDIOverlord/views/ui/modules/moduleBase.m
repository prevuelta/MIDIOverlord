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
@synthesize editMode = _editMode;

@synthesize midiV3 = _midiV3;

-(id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.width = RACK_WIDTH - 8;
    
    self.selected = NO;
    self.editMode = NO;
    
    self.labelText = @"MODULE TITLE";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEditMode:) name:@"editMode" object:nil];

    uiButton *removeBtn = [[uiButton alloc] initWithSize: 24];
    [removeBtn setOrigin: NSMakePoint(RACK_WIDTH - 24, 0)];
    
    NSarray removeBtnIcon
    
    [removeBtn setDrawArray: removeBtnIcon ];
    
    [self addSubview: removeBtn];
    
    return self;
}

-(void)addCCField {
//    controlText *midiValueText = [[controlText alloc] initWithFrame: _midiV2 andLabel: @"CC" andMaxVal:127];
    
//    [midiValueText setOrigin:NSMakePoint(0, 12)];
    
//    [midiValueText setEditable:YES];
    
//    [self bind:@"midiV2" toObject:midiValueText withKeyPath:@"value" options:nil];
    
//    [self addSubview:midiValueText];

}

-(NSMutableDictionary*)data {
    return _data;
}

-(void)setData:(NSMutableDictionary*)data {
//     NSLog(@"Data: %@", data);
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
         [self.defaultColor set];
    } else {
        [self.blackColor set];
    }

    [bgPath appendBezierPathWithRect:NSMakeRect(0, 0, self.width, self.height)];
    [bgPath closePath];
    [bgPath fill];

}

-(NSString*)labelText {
    return _labelText;
}

-(void)setLabelText:(NSString*)labelText {
//    [self.label setStringValue: labelText];
//    [self.label setNeedsDisplay:YES];
    _labelText = labelText;
}

-(NSNumber*)midiV3 {
    return _midiV3;
}

-(void)setMidiV3:(NSNumber*)midiV3 {
    _midiV3 = midiV3;
}

-(void)updateModel {
    NSLog(@"Updating modle..");
    [self.delegate moduleUpdateWithData: self.data];
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


@end

//
//  moduleBase.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/12/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "uiBase.h"

#import "controlPad.h"
#import "controlSlider.h"
#import "controlList.h"
#import "controlText.h"
#import "uiTextField.h"
#import "uiEditableTextField.h"
#import "utilities.h"
#import "uiButton.h"

@class moduleBase;

@protocol moduleBaseDelegate
-(void)midiData:(NSArray*)data;
@end

@interface moduleBase : uiBase

@property (nonatomic, assign) id delegate;

//Data
@property NSMutableDictionary* data;

// Canvas properties
@property int width;
@property int height;
@property int gridX;
@property int gridY;

// Display options
@property NSInteger tag;

// UI
@property uiTextField *label;


// Methods
-(id)initWithHeight:(int)height;
-(id)initWithFrame:(NSRect)frame;

@end

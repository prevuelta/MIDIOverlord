//
//  global.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 13/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "global.h"

static global *_instance;

@implementation global

+(global*)sharedGlobalData {
    
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
            
            _instance.patternBg = [NSImage imageNamed: @"patternBg.gif"];
            
            float blackRGBA[] = UI_COLOR_BLACK;
            float defaultRGBA[] = UI_COLOR_PROT_1;
            float bgRGBA[] = UI_COLOR_PROT_2;
            float markerRGBA[] = UI_COLOR_HIGHLIGHT;
            float activeRGBA[] = UI_COLOR_HIGHLIGHT_2;
            
           _instance.blackColor = [utilities getNSColorFromRGB:blackRGBA];
           _instance.defaultColor = [utilities getNSColorFromRGB:defaultRGBA];
           _instance.bgColor = [utilities getNSColorFromRGB:bgRGBA];
           _instance.markerColor = [utilities getNSColorFromRGB:markerRGBA];
           _instance.activeColor = [utilities getNSColorFromRGB:activeRGBA];
            
            NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
            
            [allowedCharacters addCharactersInString: @" _!@#$%^&*()-=_+[]\{}|,./<>?:\"';"];
            
            _instance.invalidChars = [allowedCharacters invertedSet];
            
        }
    }
    
    return _instance;
}

+(void)deselectNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
}

//+(void)setFirstSResponder:(id)obj {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"setFirstResponder" object:self userInfo: @{@"obj" : obj }];
//}

@end

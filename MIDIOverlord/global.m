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

@synthesize midiDestinations = _midiDestinations;

+(global*)sharedGlobalData {
    
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
            
            _instance.patternBg = [NSImage imageNamed: @"patternBg.gif"];
            
            float blackRGBA[] = MO_BLACK;
            float darkestGreyRGBA[] = MO_DARKEST_GREY;
            float darkBrownRGBA[] = MO_DARK_BROWN;
            float brownRGBA[] = MO_BROWN;
            
            float defaultRGBA[] = UI_COLOR_PROT_1;
            float bgRGBA[] = MO_BROWN_WHITE;
            float markerRGBA[] = MO_BLUE;
            float activeRGBA[] = MO_RED;
            
           _instance.black = [utilities getNSColorFromRGB:blackRGBA];
            _instance.darkestGrey = [utilities getNSColorFromRGB:darkestGreyRGBA];
            _instance.darkBrown = [utilities getNSColorFromRGB:darkBrownRGBA];
            _instance.brown = [utilities getNSColorFromRGB:brownRGBA];
            
           _instance.defaultColor = [utilities getNSColorFromRGB:defaultRGBA];
           _instance.bgColor = [utilities getNSColorFromRGB:bgRGBA];
           _instance.markerColor = [utilities getNSColorFromRGB:markerRGBA];
           _instance.activeColor = [utilities getNSColorFromRGB:activeRGBA];
            
            NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
            
            [allowedCharacters addCharactersInString: @" _!@#$%^&*()-=_+[]\\{}|,./<>?:\"';"];
            
            _instance.invalidChars = [allowedCharacters invertedSet];
            
            NSMutableCharacterSet *allowedNumbers = [NSMutableCharacterSet new];
            
            [allowedNumbers addCharactersInString: @"1234567890"];
            
            _instance.notNumbers = [allowedNumbers invertedSet];
            
        }
    }
    
    return _instance;
}

+(void)deselectNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectAll" object:self userInfo: nil];
}

-(void)setMidiDestinations:(NSMutableDictionary *)midiDestinations{
    _midiDestinations = midiDestinations;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMidiDestinations" object:self userInfo: _midiDestinations];
}

-(NSMutableDictionary *)midiDestinations {
    return _midiDestinations;
}



@end

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
            
            NSDictionary *RGBAColorValues = @{
                @"black" : @[@0, @0, @0, @255],
                @"darkestGrey" : @[@16, @16, @16, @255],
                @"darkerGrey" : @[@32, @32, @32, @255],
                @"darkGrey" : @[@48, @48, @48, @255],
                @"grey" : @[@68, @68, @68, @255],
                @"lightGrey" : @[@160, @160, @160, @255],
                @"lighterGrey" : @[@234, @234, @234, @255],
                @"lightestGrey" : @[@244, @244, @244, @255],
                @"white" : @[@255, @255, @255, @255],
                @"darkBrown" : @[@57, @47, @38, @255],
                @"brown" :  @[@149, @149, @122, @255],
                @"lighterBrown" : @[@224, @224, @201, @255],
                @"lightestBrown" : @[@245, @244, @233, @255],
                @"red" : @[@232, @65, @56, @255],
                
                @"darkBlue" : @[@23, @143, @193, @255],
                @"blue" : @[@0, @169, @232, @255],
                @"paleBlue" : @[@226, @244, @249, @255],
                @"darkPaleBlue" : @[@136, @210, @231, @255],
                
                @"purple" : @[@193, @23, @192, @255],
                @"pink" : @[@226, @87, @242, @255],
                
                @"yellow" : @[@243, @230, @30, @255]
            };
            
            _instance.colors = [NSMutableDictionary new];
            
            for(NSString *key in RGBAColorValues) {
                NSArray *RGBAArray = [RGBAColorValues objectForKey: key];
                NSColor *color = [utilities getNSColorFromRGBAArray: RGBAArray ];
                [_instance.colors setObject:color forKey: key];
            }
            
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
            
            NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet new];
            
            [allowedCharacters addCharactersInString: @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 _!@#$%^&*()-=_+[]\\{}|,./<>?:\"';"];
            
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


+(void)stopRecordingNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopRecording" object:self userInfo: nil];
}

-(void)setMidiDestinations:(NSMutableDictionary *)midiDestinations{
    _midiDestinations = midiDestinations;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMidiDestinations" object:self userInfo: _midiDestinations];
}

-(NSMutableDictionary *)midiDestinations {
    return _midiDestinations;
}

+(NSString *)uuid {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}


@end

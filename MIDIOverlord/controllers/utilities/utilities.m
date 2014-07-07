//
//  utilities.m
//  MIDIOverlord
//
//  Created by Pablo on 24/12/2013.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "utilities.h"

@implementation utilities

//+(void)notify:(int)type {
//    [self notifyWithData:type:nil];
//}
//
//+(void)notifyWithData:(int)type :(NSDictionary*)data {
//    //Types:
//    //0 : MidiNote
//    NSArray* types = @[@"noteOn", @"noteOff"];
////    NSString* typeAsString = [NSString new];
////    switch(type) {
////        case 0:
////            typeAsString = @"midiNote";
////        break;
////    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:types[type] object:self userInfo: data];
//}
//

+(NSColor*)getNSColorFromRGB:(float[])colors {
    
    float red = colors[0] / 255;
    float green = colors[1] / 255;
    float blue = colors[2] / 255;
    float alpha = colors[3] / 255;
    
    return [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
}

+(NSURL*)getSaveFileUrl {
    
    NSSavePanel* saver = [NSSavePanel savePanel];
    [saver setPrompt:@"Save file as..."];
    [saver setCanCreateDirectories:YES];
    
    [saver runModal];
    
    return [saver URL];
}


@end

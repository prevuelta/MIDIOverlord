//
//  utilities.m
//  MIDIOverlord
//
//  Created by Pablo on 24/12/2013.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "utilities.h"

@implementation utilities

Byte packetBuffer[128];

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

+(NSColor*)getNSColorFromRGBAArray:(NSArray*)color {
    
    NSLog(@"Color: %@", color[1]);
    
    float red = [color[0] floatValue] / 255;
    float green = [color[1] floatValue] / 255;
    float blue = [color[2] floatValue] / 255;
    float alpha = [color[3] floatValue] / 255;
    
    return [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
}

+(NSURL*)getSaveFileUrl {
    
    NSSavePanel* saver = [NSSavePanel savePanel];
    [saver setPrompt:@"Save file as..."];
    [saver setCanCreateDirectories:YES];
    
    [saver runModal];
    
    return [saver URL];
}

+(NSString*)noteName:(int)val {
    NSString *result = @"---";
    if(val > 0) {
        int octave = val / 12 - 1;
        NSString *notes = @"C C#D D#E F F#G G#A A#B ";
        int startIndex = (val % 12) * 2;
        int stopIndex = 2;
        NSString *note = [[notes substringFromIndex: startIndex] substringToIndex: stopIndex];
        result = [[NSString stringWithFormat:@"%@%d", note, octave-1] stringByReplacingOccurrencesOfString:@" " withString: @""];
    }
    return result;
}

+(MIDIPacketList*)getMidiPacket:(NSArray*)data {
    
    MIDIPacketList* packetList = (MIDIPacketList*)packetBuffer;
    MIDIPacket *packet;
    
    Byte msg[3] = {0xbf, (Byte)data[1], (Byte)data[2]};
    
    packet = MIDIPacketListInit(packetList);
    packet = MIDIPacketListAdd(packetList, 1024, packet, 0, 3, msg);
    
    return packetList;
    
}

@end

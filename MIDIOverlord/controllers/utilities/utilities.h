//
//  utilities.h
//  MIDIOverlord
//
//  Created by Pablo on 24/12/2013.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>

@interface utilities : NSObject

//+(void)notify:(int)type;

+(NSColor*)getNSColorFromRGB:(float[])colors;
+(NSColor*)getNSColorFromRGBAArray:(NSArray*)color;

+(NSString*)noteName:(int)val;

// App file handling
+(NSURL*)getSaveFileUrl;

+(MIDIPacketList*)getMidiPacket:(NSArray*)data;

@end

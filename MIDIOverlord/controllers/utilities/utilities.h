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

+(void)notify:(int)type;

+(void)midiNotification:(char*)status :(int)v2 :(int)v3;

+(NSColor*)getNSColorFromRGB:(float[])colors;

+(NSMutableArray*)getMidiDestinations;
+(NSString*)getDeviceName:(MIDIObjectRef)object;

// App file handling
+(NSString*)getSaveFileUrl;

@end

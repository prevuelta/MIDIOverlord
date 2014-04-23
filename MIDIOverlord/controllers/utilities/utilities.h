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

// App file handling
+(NSString*)getSaveFileUrl;

@end

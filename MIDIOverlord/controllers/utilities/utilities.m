//
//  utilities.m
//  MIDIOverlord
//
//  Created by Pablo on 24/12/2013.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "utilities.h"

@implementation utilities

+(void)notify:(int)type {
    [self notifyWithData:type:nil];
}

+(void)notifyWithData:(int)type :(NSDictionary*)data {
    //Types:
    //0 : MidiNote
    NSArray* types = @[@"noteOn", @"noteOff"];
//    NSString* typeAsString = [NSString new];
//    switch(type) {
//        case 0:
//            typeAsString = @"midiNote";
//        break;
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:types[type] object:self userInfo: data];
}

+(void)midiNotification:(char*)status :(int)v2 :(int)v3{
    NSDictionary *data =@{
        @"status" : [NSNumber numberWithInt:status],
        @"v2" : [NSNumber numberWithInt:v2],
        @"v3" : [NSNumber numberWithInt:v3]
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"midiMessage" object:self userInfo: data];
}

+(NSColor*)getNSColorFromRGB:(float[])colors {
    
    float red = colors[0] / 255;
    float green = colors[1] / 255;
    float blue = colors[2] / 255;
    float alpha = colors[3] / 255;
    
    return [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
}

+(NSMutableArray*)getMidiDestinations {
    
    NSMutableArray *destinations = [NSMutableArray new];
    
    ItemCount destCount = MIDIGetNumberOfDestinations();
    
    ItemCount sourceCount = MIDIGetNumberOfSources();
    
    NSLog(@"sources: %i", (int)sourceCount);
    NSLog(@"Destinationcount: %i", (int)destCount);
    
    for (ItemCount i = 0 ; i < destCount ; ++i) {
        
        // Grab a reference to a destination endpoint
        MIDIEndpointRef dest = MIDIGetDestination(i);
        if (dest) {
            NSNumber *deviceID = [NSNumber numberWithInt: [self getDeviceID:dest]];
//            [destinations setValue:deviceID forKey:[self getDeviceName:dest] ];
            
            [destinations addObject:[self getDeviceName:dest]];
            [destinations addObject: deviceID];
        }
    }
    
    return destinations;
}

+(NSString*)getDeviceName:(MIDIObjectRef)object{
    // Returns the display name of a given MIDIObjectRef as an NSString
    CFStringRef name = nil;
    if (noErr != MIDIObjectGetStringProperty(object, kMIDIPropertyDisplayName, &name)) {
        return nil;
    }
    return (NSString*)CFBridgingRelease(name);
}

+(int)getDeviceID:(MIDIObjectRef)object {
    int deviceID;
    if(noErr != MIDIObjectGetIntegerProperty(object, kMIDIPropertyUniqueID, &deviceID)) {
        return nil;
    }
    return deviceID;
}

+(NSString*)getSaveFileUrl {
    
    NSSavePanel* saver = [NSSavePanel savePanel];
    [saver setPrompt:@"Save file as..."];
    [saver setCanCreateDirectories:YES];
    
    [saver runModal];
    
    return [saver URL];
}

+(void)selectFileDialogue {
   
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    [openDlg setPrompt:@"Select"];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];
    
    // Enable the selection of directories in the dialog.
    [openDlg setCanChooseDirectories:YES];
    
    NSArray* imageTypes = [NSImage imageTypes];
    
    [openDlg setAllowedFileTypes:imageTypes];
    
    [openDlg runModal];
}

@end

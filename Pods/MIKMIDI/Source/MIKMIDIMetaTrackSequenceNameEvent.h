//
//  MIKMIDIMetaTrackSequenceNameEvent.h
//  MIDI Files Testbed
//
//  Created by Jake Gundersen on 5/22/14.
//  Copyright (c) 2014 Mixed In Key. All rights reserved.
//

#import "MIKMIDIMetaTextEvent.h"

/**
 *  A meta event containing a track name.
 */
@interface MIKMIDIMetaTrackSequenceNameEvent : MIKMIDIMetaTextEvent

@property (nonatomic, readonly) NSString *name;

@end

/**
 *  The mutable counterpart of MIKMIDIMetaTrackSequenceNameEvent
 */
@interface MIKMutableMIDIMetaTrackSequenceNameEvent : MIKMIDIMetaTrackSequenceNameEvent

@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, readwrite) MusicTimeStamp timeStamp;
@property (nonatomic, readwrite) UInt8 metadataType;
@property (nonatomic, strong, readwrite) NSData *metaData;
@property (nonatomic, copy, readwrite) NSString *string;

@end
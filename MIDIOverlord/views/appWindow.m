//
//  appWindow.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 9/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "appWindow.h"

@implementation appWindow

-(id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    NSLog(@"is init");
    self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeWindow:) name:@"closeWindow" object:nil];
    //
    return self;
}

//-(id)init {
//    self = [super init];
//    if(!self) return nil;
//    
//    NSLog(@"is init");
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performClose:) name:@"closeWindow" object:nil];
//    
//    return self;
//}

-(BOOL)canBecomeKeyWindow {
    return YES;
}


-(void)closeWindow:(NSNotification*)notification {
    NSLog(@"close win");
    NSAlert* closeAlert = [[NSAlert alloc] init];
    [closeAlert setMessageText:@"Are you sure you want to quit?"];
    [closeAlert addButtonWithTitle:@"OK"];
    [closeAlert addButtonWithTitle:@"Cancel"];
    if ([closeAlert runModal] == NSAlertFirstButtonReturn) {
        [self close];
        [NSApp terminate:self];
    }
}

@end

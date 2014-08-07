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
    
    /* Observers */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeWindow:) name:@"closeWindow" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(maxWindow:) name:@"maxWindow" object:nil];
    
    return self;
}

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

-(void)maxWindow:(NSNotification*)notification {
    NSRect screenFrame = [[NSScreen mainScreen] visibleFrame];
    [self setFrame: screenFrame display: YES];
}

//NSPoint currentLocation;
//NSPoint newOrigin;
//
//NSRect  screenFrame = [[NSScreen mainScreen] visibleFrame];
//NSRect  windowFrame = [self.window frame];
//
//currentLocation = [NSEvent mouseLocation];
//newOrigin.x = currentLocation.x - initialLocation.x;
//newOrigin.y = currentLocation.y - initialLocation.y;
//
//if( (newOrigin.y + windowFrame.size.height) > (screenFrame.origin.y + screenFrame.size.height ) ){
//    NSLog(@"Hitting menu");
//    newOrigin.y=screenFrame.origin.y + (screenFrame.size.height - windowFrame.size.height);
//}
//
//[[self window] setFrameOrigin:newOrigin];

@end

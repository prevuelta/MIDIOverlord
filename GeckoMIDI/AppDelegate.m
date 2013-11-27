//
//  AppDelegate.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "AppDelegate.h"
#import "Grid.h"

@implementation AppDelegate

@synthesize textField;
@synthesize slider;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    // Change window color to white
    // self.window.backgroundColor = [NSColor whiteColor];
    // Trying to add custom view
    Grid *mainGrid = [[Grid alloc] init];
    
    mainGrid.XDivisions = 10;
    mainGrid.YDivisions = 10;
    
}

    
- (IBAction)mute:(id)sender {
    NSLog(@"Received a mute: message");
}

- (IBAction)takeFloatValueForVolumeFrom:(id)sender {
    NSString *senderName = nil;
    if(sender == self.textField) {
        senderName = @"textField";
        
    } else {
        senderName= @"slider";
    }
    NSLog(@"%@ sent takeFloatValueForVolumeFrom: with vluae %1.2f", senderName, [sender floatValue]);
}
@end

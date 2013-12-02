//
//  AppDelegate.m
//  GeckoMIDI
//
//  Created by Pablo Revuelta on 26/11/13.
//  Copyright (c) 2013 Midnight City. All rights reserved.
//

#import "AppDelegate.h"
#import "gmGrid.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    // Insert code here to initialize your application
    // Change window color to white
   
    // Trying to add custom view
    gmGrid *mainGrid = [[gmGrid alloc] init];
    
    self.mainWin.backgroundColor = [NSColor whiteColor];
    
    [self.mainWin setContentView: mainGrid];
    

}

- (IBAction)makeView:(id)sender {
    NSLog(@"Making view...");
}


@end

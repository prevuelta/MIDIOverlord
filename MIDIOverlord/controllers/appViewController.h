//
//  appViewController.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 2/04/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "appView.h"
#import "appModel.h"

@interface appViewController : NSViewController <appViewDelegate>

@property (strong, atomic) appView *mainView;
@property (strong, atomic) appModel *data;

-(id)initWithWin:(NSWindow*)mainWin;

@end

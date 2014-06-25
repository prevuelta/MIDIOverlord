//
//  scrollableView.h
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 20/06/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "uiBase.h"
#import "controlScrollBar.h"

@interface scrollableView : uiBase

@property int heightOfSubviews;
@property controlScrollBar *scrollBar;
@property uiBase *clippedView;

-(void)activateScrollBar;
-(void)deactivateScrollBar;

-(void)addModuleView:(uiBase*)aView;
-(void)checkClippedViewPosition;
-(void)anchorClippedViewToBottom;

@end

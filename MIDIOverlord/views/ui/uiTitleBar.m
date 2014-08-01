//
//  uiTitleBar.m
//  MIDIOverlord
//
//  Created by Pablo Revuelta on 9/07/14.
//  Copyright (c) 2014 Midnight City. All rights reserved.
//

#import "uiTitleBar.h"

@implementation uiTitleBar

NSPoint initialLocation;

@synthesize title = _title;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    NSString* testString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890_!@#$%^&*()-=_+[]\{}|,./<>?:\"";
    
//    uiTextField *appTitle = [[uiTextField alloc] initWithString: @"Untitled"];
     uiTextField *appTitle = [[uiTextField alloc] initWithString: testString];
    
    [appTitle setOrigin:NSMakePoint(20, 2)];
    
//    [appTitle bind:@"stringValue" toObject:self withKeyPath: @"title" options: nil];

    [self addSubview: appTitle];
    
    uiButton *closeWindow = [[uiButton alloc] initWithSize: 16];
    [closeWindow setEvent:@"closeWindow"];
    [closeWindow setOrigin: NSMakePoint(2, 2)];
    
    [self addSubview: closeWindow];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    
    if(self.active) {
        [[global sharedGlobalData].darkBrown setFill];
    } else {
        [[global sharedGlobalData].darkestGrey setFill];
    }
    NSRectFill(dirtyRect);
    
    [super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(void)mouseDown:(NSEvent*)theEvent {
    
    self.selected = YES;
    
    NSRect  windowFrame = [[self window] frame];
    
    initialLocation = [NSEvent mouseLocation];
    
    initialLocation.x -= windowFrame.origin.x;
    initialLocation.y -= windowFrame.origin.y;
}

- (void)mouseDragged:(NSEvent *)theEvent {
    NSPoint currentLocation;
    NSPoint newOrigin;
    
    NSRect  screenFrame = [[NSScreen mainScreen] visibleFrame];
    NSRect  windowFrame = [self.window frame];
    
    currentLocation = [NSEvent mouseLocation];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    if( (newOrigin.y + windowFrame.size.height) > (screenFrame.origin.y + screenFrame.size.height ) ){
        NSLog(@"Hitting menu");
        newOrigin.y=screenFrame.origin.y + (screenFrame.size.height - windowFrame.size.height);
    }
    
    [[self window] setFrameOrigin:newOrigin];
    
    //go ahead and move the window to the new location
    
}

-(void)mouseUp:(NSEvent *)theEvent {
    self.selected = NO;
}

-(BOOL)mouseDownCanMoveWindow {
    return YES;
}

//-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
//    return YES;
//}

//-(void)mouseDown:(NSEvent*)theEvent {
//    NSLog(@"Title bar clicked");
//    [self.window setMovableByWindowBackground:YES];
//}
//
//-(void)mouseUp:(NSEvent *)theEvent {
//    [self.window setMovableByWindowBackground:NO];
//}

-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}

- (BOOL) acceptsFirstResponder
{
    return YES;
}


@end

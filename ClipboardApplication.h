//
//  ClipboardAppDelegate.h
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ClipboardWindowController;

@interface ClipboardApplication : NSObject { 
	ClipboardWindowController *mainWindowController;
}
@property (retain, readonly) ClipboardWindowController *mainWindowController;
- (void)pluginDidLaunch;

- (void)toggleApplicationWindow;
- (void)sendMessage:(NSString*)message;
@end

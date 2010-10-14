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
	NSString *appName;
	NSString *appVersion;
}
@property (retain, readonly) ClipboardWindowController *mainWindowController;
@property (copy) NSString *appName;
@property (copy) NSString *appVersion;

- (void)pluginDidLaunch;

- (void)toggleApplicationWindow;
- (void)sendMessage:(NSString*)message;
@end

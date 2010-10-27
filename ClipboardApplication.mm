//
//  ClipboardAppDelegate.m
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "ClipboardApplication.h"
#import "ClipboardWindowController.h"
#import "ClipboardCadHelper.h"

static ClipboardApplication *plugin = nil;

void startClipManagerPlugin() {
	plugin = [[[ClipboardApplication alloc] init] autorelease];
	[plugin pluginDidLaunch];
}

void endClipManagerPlugin() {
	[plugin release], plugin = nil;
}

void toggleClipManagerWindow() {
	[plugin toggleApplicationWindow];
}

@implementation ClipboardApplication

#pragma mark -
#pragma mark memory management

- (void)dealloc
{
	[mainWindowController release], mainWindowController = nil;
	[appName release], appName = nil;
	[appVersion release], appVersion = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark life cycle

- (void)pluginDidLaunch;
{
	NSBundle *pluginBundle = [NSBundle bundleForClass:[self class]];
	[self setAppName:[pluginBundle objectForInfoDictionaryKey:@"CFBundleName"]];
	[self setAppVersion:[pluginBundle objectForInfoDictionaryKey:@"CFBundleVersion"]];
	
	NSLog(@"Loading/launching :  \"%@.bundle\"", [self appName]);
	NSString *startupMessage = [NSString stringWithFormat:@"\r\n%@ version %@ loaded...\r\n", [self appName], [self appVersion]];
	[self sendMessage:startupMessage];
	
	// start window controller
	mainWindowController = [[[ClipboardWindowController alloc] initWithWindowNibName:@"MainWindow"] retain];
	[[mainWindowController window] setTitle:[self appName]];
}

- (void)toggleApplicationWindow;
{
	if ([[mainWindowController window] isVisible]) {
		[[mainWindowController window] orderOut:nil];
	}
	else {
		[[mainWindowController window] makeKeyAndOrderFront:nil];
	}
}

#pragma mark -
#pragma mark helpers

- (void)sendMessage:(NSString*)message;
{
	[[ClipboardCadHelper sharedClipboardCadHelper] sendMessage:message];
}

+ (ClipboardApplication *)sharedApplication;
{
	return plugin;
}

#pragma mark -
#pragma mark property synths / overrides

@synthesize mainWindowController, appName, appVersion;

@end

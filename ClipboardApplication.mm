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
	[super dealloc];
}

#pragma mark -
#pragma mark life cycle

- (void)pluginDidLaunch;
{
	NSBundle *pluginBundle = [NSBundle bundleForClass:[self class]];
	NSString *pluginName = [pluginBundle objectForInfoDictionaryKey:@"CFBundleName"];
	NSString *versionString = [pluginBundle objectForInfoDictionaryKey:@"CFBundleVersion"];
	NSString *startupMessage = [NSString stringWithFormat:@"\n----------\r\n%@ version %@ launched...\r\n----------\r\n", pluginName, versionString];
	[self sendMessage:startupMessage];
	
	// start window controller
	mainWindowController = [[[ClipboardWindowController alloc] initWithWindowNibName:@"MainWindow"] retain];
}

- (void)toggleApplicationWindow;
{
	[mainWindowController showWindow:nil];
}

#pragma mark -
#pragma mark helpers

- (void)sendMessage:(NSString*)message;
{
	[[ClipboardCadHelper sharedClipboardCadHelper] sendMessage:message];
}

@synthesize mainWindowController;

@end

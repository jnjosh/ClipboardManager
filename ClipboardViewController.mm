//
//  ClipboardViewController.m
//  ClipboardManager
//
//  Created by Josh Johnson on 10/14/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "ClipboardViewController.h"
#import "ClipboardCadHelper.h"

@implementation ClipboardViewController

#pragma mark -
#pragma mark memory

- (void)dealloc
{
	[self unregisterToMonitorClipboardItems];
	[tableView release], tableView = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark setup/cleanup

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self registerToMonitorClipboardItems];
	}
	return self;
}

- (id)init
{
	if (self = [super init]) {
		[self registerToMonitorClipboardItems];
	}
	return self;
}

- (void)registerToMonitorClipboardItems;
{
	//http://en.wikibooks.org/wiki/Programming_Mac_OS_X_with_Cocoa_for_Beginners/Archiving
	/*
	NSPasteboard *cb = [NSPasteboard generalPasteboard];
	for (NSString *type_string in [cb types]) {
		if ([type_string isEqualToString:@"com.autodesk.autocad.drawing"]) {
			[[ClipboardCadHelper sharedClipboardCadHelper] sendMessage:type_string];
		}
	}
	*/
	
	// http://www.cocoadev.com/index.pl?NSTableViewTutorial
}

- (void)unregisterToMonitorClipboardItems;
{
}

#pragma mark -
#pragma mark button actions

- (IBAction)clearAllAction:(id)sender;
{
	[self clearAllClipboardItems];
}

#pragma mark -
#pragma mark clipboard management

- (void)clearAllClipboardItems;
{
}

- (void)addClipboardItem;
{
}


@end

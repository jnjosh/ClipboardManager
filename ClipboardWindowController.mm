//
//  ClipboardWindowController.m
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "ClipboardWindowController.h"
#import "ClipboardViewController.h"
#import "ClipboardAboutWindowController.h"
#import "ClipboardCadHelper.h"

@implementation ClipboardWindowController

- (void)dealloc 
{
	[mainViewController release], mainViewController = nil;
	[super dealloc];
}

- (IBAction)showAboutWindow;
{
	ClipboardAboutWindowController *aboutWindow = [[ClipboardAboutWindowController alloc] initWithWindowNibName:@"AboutWindow"];
	[aboutWindow showWindow:nil];
}

@end

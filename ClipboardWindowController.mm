//
//  ClipboardWindowController.m
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "ClipboardWindowController.h"
#import "ClipboardCadHelper.h"

@implementation ClipboardWindowController

- (IBAction)saySomething:(id)sender;
{
	[[ClipboardCadHelper sharedClipboardCadHelper] sendMessage:[messageField stringValue]];
}

@end

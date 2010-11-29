//
//  ClipboardCadHelper.mm
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "ClipboardCadHelper.h"
#import "SynthesizeSingletons.h"
#include <aced.h>
#include <adscodes.h>

NSString *ADSKPasteboardTypeString = @"com.autodesk.autocad.drawing";

@implementation ClipboardCadHelper
SYNTHESIZE_SINGLETON_FOR_CLASS(ClipboardCadHelper);

- (void)sendMessage:(NSString *)message; 
{
	NSString *messageString = [NSString stringWithFormat:@"\r\n%@\r\n", message];
	acutPrintf((const ACHAR *)[messageString cStringUsingEncoding:NSUTF32LittleEndianStringEncoding]);
}

- (void)beginPaste;
{
	// crappy test code that doesn't work ... brain needs ARX refresher
	struct resbuf *cmdlist;
	cmdlist = acutBuildList(RTSTR, L"_pasteclip", RTNONE);
	if (cmdlist == NULL) {
		acdbFail(L"No list, sorry");
		return;
	}
	acedCmd(cmdlist);
	acutRelRb(cmdlist);
}

- (NSString *)documentDescription:(NSString *)document;
{
	if (document == nil || [document isEqualToString:@""]) return @"Unknown Drawing Information";
	return @"";
}

@end 

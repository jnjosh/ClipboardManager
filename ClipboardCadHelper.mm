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

@implementation ClipboardCadHelper
SYNTHESIZE_SINGLETON_FOR_CLASS(ClipboardCadHelper);

- (void)sendMessage:(NSString *)message; 
{
	NSString *messageString = [NSString stringWithFormat:@"\r\n%@\r\n", message];
	acutPrintf((const ACHAR *)[messageString cStringUsingEncoding:NSUTF32LittleEndianStringEncoding]);
}

@end

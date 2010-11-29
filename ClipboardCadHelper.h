//
//  ClipboardCadHelper.h
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *ADSKPasteboardTypeString;

@interface ClipboardCadHelper : NSObject {
}
+ (ClipboardCadHelper *)sharedClipboardCadHelper;

- (void)sendMessage:(NSString *)message;
- (void)beginPaste;

- (NSString *)documentDescription:(NSString *)document;
@end

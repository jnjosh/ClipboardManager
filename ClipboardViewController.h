//
//  ClipboardViewController.h
//  ClipboardManager
//
//  Created by Josh Johnson on 10/14/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <BWToolkitFramework/BWToolkitFramework.h>

@interface ClipboardViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet BWTransparentTableView *tableView;
@private
	NSMutableArray *tableViewCellValues;
	NSMutableArray *clipboardData;

	NSTimer *pollPasteboardTimer;
	NSInteger originCount;
	NSUInteger clipboardCounter;
}
- (IBAction)clearAllAction:(id)sender;

- (void)pasteboardUpdated;

- (void)clearAllClipboardItems;
- (void)addClipboardItem;
- (void)registerToMonitorClipboardItems;
- (void)unregisterToMonitorClipboardItems;

@end

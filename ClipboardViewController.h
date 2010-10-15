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
}
- (IBAction)clearAllAction:(id)sender;

- (void)clearAllClipboardItems;
- (void)addClipboardItem;
- (void)registerToMonitorClipboardItems;
- (void)unregisterToMonitorClipboardItems;

@end

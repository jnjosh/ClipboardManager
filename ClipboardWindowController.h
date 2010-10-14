//
//  ClipboardWindowController.h
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ClipboardViewController;

@interface ClipboardWindowController : NSWindowController {
	IBOutlet ClipboardViewController *mainViewController;
}
- (IBAction)showAboutWindow;
@end

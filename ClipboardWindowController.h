//
//  ClipboardWindowController.h
//  ClipboardManager
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ClipboardWindowController : NSWindowController {
	IBOutlet NSTextField *messageField;
}
- (IBAction)saySomething:(id)sender;
@end

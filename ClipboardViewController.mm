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
		tableViewCellValues = [[NSMutableArray alloc] init];
		[self registerToMonitorClipboardItems];
	}
	return self;
}

- (void)registerToMonitorClipboardItems;
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[pb declareTypes:[NSArray arrayWithObject:ADSKPasteboardTypeString] owner:nil];
	originCount = [pb changeCount];
	pollPasteboardTimer = [[NSTimer scheduledTimerWithTimeInterval:1.0
														   target:self 
														 selector:@selector(pasteboardUpdated)
														 userInfo:nil 
														   repeats:YES] retain];
	
	//http://en.wikibooks.org/wiki/Programming_Mac_OS_X_with_Cocoa_for_Beginners/Archiving
	//http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/PasteboardGuide106/Articles/pbUpdating105.html
	// http://www.cocoadev.com/index.pl?NSTableViewTutorial
}

- (void)unregisterToMonitorClipboardItems;
{
	[pollPasteboardTimer invalidate];
	[pollPasteboardTimer release];
}

#pragma mark -
#pragma mark Table View Delegate Req.

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return [tableViewCellValues count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
{
	return [tableViewCellValues objectAtIndex:row];
}

#pragma mark -
#pragma mark button actions

- (IBAction)clearAllAction:(id)sender;
{
	[self clearAllClipboardItems];
}

#pragma mark -
#pragma mark clipboard management

- (void)pasteboardUpdated;
{
	NSInteger currentCount = [[NSPasteboard generalPasteboard] changeCount];
	if (currentCount != originCount) {
		originCount = currentCount;
		if ([[NSPasteboard generalPasteboard] availableTypeFromArray:[NSArray arrayWithObject:ADSKPasteboardTypeString]]) {
			[self addClipboardItem];
		}
	}
}

- (void)addClipboardItem;
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];

	// add item to array
	// reflect on entities
	//	NSLog(@"value: %@", [cb dataForType:@"com.autodesk.autocad.drawing"]);	
	
	[tableViewCellValues addObject:[NSString stringWithFormat:@"New Data in clipboard - %i", originCount]];
	[tableView reloadData];
}

- (void)clearAllClipboardItems;
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[pb clearContents];
	
	[tableViewCellValues removeAllObjects];
	[tableViewCellValues release];
	tableViewCellValues = [[NSMutableArray alloc] init];
	[tableView reloadData];
}

@end

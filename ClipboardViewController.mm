//
//  ClipboardViewController.m
//  ClipboardManager
//
//  Created by Josh Johnson on 10/14/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "ClipboardViewController.h"
#import "ClipboardApplication.h"
#import "ClipboardCadHelper.h"

@implementation ClipboardViewController

#pragma mark -
#pragma mark memory

- (void)dealloc
{
	[self unregisterToMonitorClipboardItems];
	[tableView release], tableView = nil;
	[clipboardData release], clipboardData = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark setup/cleanup

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		clipboardData = [[NSMutableArray alloc] init];
		tableViewCellValues = [[NSMutableArray alloc] init];
		[self registerToMonitorClipboardItems];
	}
	return self;
}

- (void)registerToMonitorClipboardItems;
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	originCount = [pb changeCount];
	pollPasteboardTimer = [[NSTimer scheduledTimerWithTimeInterval:1.0
														   target:self 
														 selector:@selector(pasteboardUpdated)
														 userInfo:nil 
														   repeats:YES] retain];
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

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	[self unregisterToMonitorClipboardItems];
	NSUInteger selectedItem;
	BWTransparentTableView *tv = [notification object];
	selectedItem = [[tv selectedRowIndexes] firstIndex];
	
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[pb clearContents];
	
	NSMutableDictionary *pbData = [clipboardData objectAtIndex:(clipboardCounter-1)];
	for (NSString *key in [pbData allKeys]) {
		NSLog(@"set data for key = %@ --> %@", key, [pbData objectForKey:key] == nil ? @"NO" : @"YES");
		[pb setData:[pbData objectForKey:key] forType:key];
	}
	
	[[ClipboardCadHelper sharedClipboardCadHelper] beginPaste];
	
	[self registerToMonitorClipboardItems];
}

#pragma mark -
#pragma mark button actions

- (IBAction)clearAllAction:(id)sender;
{
	clipboardCounter = 0;
	[self clearAllClipboardItems];
}

#pragma mark -
#pragma mark clipboard management

- (void)pasteboardUpdated;
{
	NSInteger currentCount = [[NSPasteboard generalPasteboard] changeCount];
	if (currentCount != originCount) {
		originCount = currentCount;
		////
		
		
		NSMutableArray *classes = [NSMutableArray array];
		[classes addObject:[NSPasteboardItem class]];
		NSDictionary *options = [NSDictionary dictionary];
		NSArray *copiedItems = [[NSPasteboard generalPasteboard] readObjectsForClasses:classes options:options];
		if (copiedItems != nil) {
			NSPasteboardItem *item = [copiedItems objectAtIndex:0];
			
			NSLog(@"SOMETHING HERE!!! %@",[item types]);
			
			NSLog(@"copied items :: %@", copiedItems);
		}
		
		
		////
		if ([[NSPasteboard generalPasteboard] availableTypeFromArray:[NSArray arrayWithObject:ADSKPasteboardTypeString]]) {
			[self addClipboardItem];
		}
	}
}

- (void)addClipboardItem;
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	NSDate *dateNow = [NSDate date];
	NSLocale *thisLocale = [NSLocale currentLocale];
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setLocale:thisLocale];
	[format setFormatterBehavior:NSDateFormatterMediumStyle];
	[format setDateFormat:@"hh:mm a"];
	NSString *timeStamp = [format stringFromDate:dateNow];
	
	clipboardCounter++;

	//public.utf16-plain-text
	
	NSMutableDictionary *pbData = [[NSMutableDictionary alloc] init];
	for (NSString *typeName in [pb types]) {
		NSLog(@"The Type = %@", typeName); 
		NSLog(@"Value %@", [pb dataForType:typeName]);
		NSLog(@"Value %@", [pb dataForType:NSFilenamesPboardType]);
		NSLog(@"Value %@", [pb dataForType:NSStringPboardType]);
		NSLog(@"Value %@", [pb dataForType:@"CorePasteboardFlavorType 0x75747874"]);

		[pbData setObject:[pb dataForType:typeName] forKey:typeName];
	}
	[clipboardData addObject:pbData];
	[tableViewCellValues addObject:[NSString stringWithFormat:@"Clipboard Entry #%i - %@", clipboardCounter, timeStamp]];
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

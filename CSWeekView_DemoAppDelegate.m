//
//  CSWeekView_DemoAppDelegate.m
//  CSWeekView Demo
//
//  Created by David Hirsch on 12/20/09.
//  Copyright 2009 Western Washington University. All rights reserved.
//

#import "CSWeekView_DemoAppDelegate.h"
#import "MyModelObject.h"
#import "CSWeekView.h"

@implementation CSWeekView_DemoAppDelegate

@synthesize window, theModelObjects;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	theModelObjects = [[NSMutableArray arrayWithCapacity:10] retain];	// this will leak, but we are just a demo app
	// add a few events
	MyModelObject *thisObj = [[MyModelObject alloc] init];
	thisObj.name = @"Event 1";
	thisObj.startTime = 4;
	thisObj.duration = 2;
	thisObj.day = 2;
	thisObj.color = [NSColor blueColor];
	[myArrayController addObject:thisObj];
	thisObj = [[MyModelObject alloc] init];
	thisObj.name = @"Event 2";
	thisObj.startTime = 5;
	thisObj.duration = 2;
	thisObj.day = 2;
	thisObj.color = [NSColor greenColor];
	[myArrayController addObject:thisObj];
	thisObj = [[MyModelObject alloc] init];
	thisObj.name = @"Event 3";
	thisObj.startTime = 3;
	thisObj.duration = 6;
	thisObj.day = 2;
	thisObj.color = [NSColor orangeColor];
	[myArrayController addObject:thisObj];
	thisObj = [[MyModelObject alloc] init];
	thisObj.name = @"Event 4";
	thisObj.startTime = 6;
	thisObj.duration = 2;
	thisObj.day = 2;
	thisObj.color = [NSColor redColor];
	[myArrayController addObject:thisObj];
	[self updateWeekView:self];
}

- (IBAction) updateWeekView: (id) sender {
	// Need to give the week view all the events it needs to display
	NSMutableArray *events = [NSMutableArray arrayWithCapacity:5];
	NSMutableArray *dayEvents;
	for (short day = 0; day <=4; day++) {
		NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"day == %d", day];
		NSArray *theseDayInstances = [[self theModelObjects] filteredArrayUsingPredicate:dayPredicate];
		dayEvents = [NSMutableArray arrayWithCapacity:[theseDayInstances count]];
		for (MyModelObject *thisObj in theseDayInstances) {
			NSDictionary *thisEvent = [NSDictionary dictionaryWithObjectsAndKeys:
									   [NSNumber numberWithInt: [thisObj startTime]], @"startTime",
									   [NSNumber numberWithInt: [thisObj duration]], @"duration",
									   [thisObj name], @"label",
									   [thisObj color], @"color",
									   nil];
			[dayEvents addObject:thisEvent];
		}
		[events addObject:dayEvents];
	}
	[theWeekView updateEvents:events];
}
@end

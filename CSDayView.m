//
//  CSDayView.m
//
//  Created by David Hirsch on 12/17/09.
//  Copyright 2009 David Hirsch (CSWeekView@davehirsch.com)
/*
 This file is part of CSWeekView.
 
 CSWeekView is free software: you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 CSWeekView is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public License
 along with CSWeekView.  If not, see <http://www.gnu.org/licenses/>.
 */ 

#import "CSDayView.h"
#import "CSEventView.h"
#import "CSWeekView.h"

@implementation CSDayView

@synthesize dayName, backColor;

- (void) updateEvents: (NSArray *) events {
	NSArray *subviews = [self subviews];
	for (short svNum = [subviews count]; svNum > 0; svNum--) {
		CSEventView *thisSubview = [subviews objectAtIndex:svNum-1];
		[thisSubview removeFromSuperview];
		[thisSubview release];
	}
	
	bool occupied[(kNumHoursToShow * 60 / kMinutesPerTimeUnit)][kMaxNumSimultaneousEvents];	// this is for layout of events.  Spaces taken are marked as true.  Only kMaxNumSimultaneousEvents events at one time!
	short i, j;
	for(i = 0; i < kNumHoursToShow * 60 / kMinutesPerTimeUnit; i++) {
		for(j = 0; j < kMaxNumSimultaneousEvents; j++) {
			occupied[i][j] = false;
		}
	}

	NSSize newSize = NSMakeSize([self frame].size.width, kMinDayHeight);
	[self setFrameSize:newSize];
	
	for (NSDictionary *thisEvent in events) {
		NSUInteger startTime = [[thisEvent objectForKey:@"startTime"] intValue];
		NSUInteger duration = [[thisEvent objectForKey:@"duration"] intValue];
		// figure out highest (lowest-numbered) time block that can accommodate this event
		short curRow = 0;
		short goodRow = -1;
		while (goodRow == -1) {
			BOOL foundGoodBlock = YES;
			for (NSUInteger thisTime = startTime; thisTime <= startTime + duration - 1; thisTime++) {
				if (occupied[thisTime][curRow]) {
					foundGoodBlock = NO;
				}
			}
			if (foundGoodBlock) {
				// mark those as occupied
				for (NSUInteger thisTime = startTime; thisTime <= startTime + duration - 1; thisTime++) {
					occupied[thisTime][curRow] = true;
				}
				goodRow = curRow;
			}
			curRow++;
		}
		
		// now we have the correct row in which to place the event, so translate that into a position within the view
		float thisWidth = kHourWidth * duration * kMinutesPerTimeUnit / 60.0;
		float thisLeft = kLeftHeaderSpace + (kHourWidth * startTime * kMinutesPerTimeUnit / 60.0);
		float myTop = [self bounds].origin.y + [self bounds].size.height;
		float thisBottom = myTop - (kEventHeight * (goodRow + 1));
		float totalNeededHeight = myTop - thisBottom;
		if ([self frame].size.height < totalNeededHeight) {
			newSize = NSMakeSize([self frame].size.width, totalNeededHeight);
			float vOffset = totalNeededHeight - [self frame].size.height;
			[self setFrameSize:newSize];
			// need to move existing subviews up, since we don't autoresize
			for (NSView *thisSubView in [self subviews]) {
				[thisSubView setFrameOrigin:NSMakePoint([thisSubView frame].origin.x, [thisSubView frame].origin.y + vOffset)];
			}
			// Now that we've expanded ourself, the previous bottom is potentially inaccurate
			if (thisBottom < 0) {
				thisBottom += vOffset;
			}
		}
		NSRect frame = NSMakeRect(thisLeft, thisBottom, thisWidth, kEventHeight);
		CSEventView *newEventView = [[CSEventView alloc] initWithFrame: frame];
		[newEventView setupWithStartTime: [thisEvent objectForKey:@"startTime"]
								duration: [thisEvent objectForKey:@"duration"]
								   label: [thisEvent objectForKey:@"label"]
								   color: [thisEvent objectForKey:@"color"]];
		[self addSubview:newEventView];
	}
}

- (void)drawRect:(NSRect)rect
{
    [backColor set];
    [NSBezierPath fillRect:rect];
	NSRect myBounds = [self bounds];
    [[NSColor blackColor] set];
	NSDictionary *headerAttr = [NSDictionary dictionaryWithObject: [NSFont boldSystemFontOfSize:11.0]
														   forKey:NSFontAttributeName];
	NSSize oneHeaderSize = NSMakeSize(20, myBounds.size.height);	// need to make this an ivar
	NSRect stringRect = {myBounds.origin, oneHeaderSize};
	[[self dayName] drawInRect:stringRect withAttributes:headerAttr];
	
	// draw top boundary
	NSBezierPath *path = [[NSBezierPath alloc] init];
	[path setLineWidth:1.0];
	NSPoint startPt = NSMakePoint(0, myBounds.origin.y + myBounds.size.height);
	NSPoint endPt = NSMakePoint(myBounds.size.width, myBounds.origin.y + myBounds.size.height);
	[path moveToPoint:startPt];
	[path lineToPoint:endPt];
	[path closePath];
	[path stroke];
	[path release];
}

@end

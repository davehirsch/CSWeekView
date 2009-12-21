//
//  CSWeekView.m
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

#import "CSWeekView.h"
#import "CSDayView.h"

@implementation CSWeekView

- (void) awakeFromNib {
	// set up my subviews
	[mon setDayName:@"M"];
	[tue setDayName:@"T"];
	[wed setDayName:@"W"];
	[thu setDayName:@"R"];
	[fri setDayName:@"F"];
	[mon setBackColor:[NSColor colorWithDeviceRed:0.4 green:0.4 blue:1.0 alpha:0.1]];
	[tue setBackColor:[NSColor colorWithDeviceRed:1.0 green:0.4 blue:0.4 alpha:0.1]];
	[wed setBackColor:[NSColor colorWithDeviceRed:0.4 green:1.0 blue:0.4 alpha:0.1]];
	[thu setBackColor:[NSColor colorWithDeviceRed:1.0 green:0.1 blue:1.0 alpha:0.1]];
	[fri setBackColor:[NSColor colorWithDeviceRed:1.0 green:1.0 blue:0.1 alpha:0.1]];
}

- (void)drawRect:(NSRect)rect
{
    // erase the background by drawing white
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:rect];

	NSRect myBounds = [self bounds];
	NSDictionary *headerAttr = [NSDictionary dictionaryWithObject: [NSFont boldSystemFontOfSize:kHeaderFontSize]
														forKey:NSFontAttributeName];
	NSSize oneHeaderSize = NSMakeSize(kHourWidth, kTopHeaderSpace);
	short initialLeft = kLeftHeaderSpace;
    [[NSColor blackColor] set];
	for (short hourNum=0; hourNum <= kNumHoursToShow-1; hourNum++) {
		short hour = hourNum + kHourZero;
		if (hour > 12) hour -= 12;
		NSPoint rectPos = NSMakePoint(initialLeft + hourNum * kHourWidth, myBounds.size.height - kTopHeaderSpace);
		NSString *hourStr = [NSString stringWithFormat:@"%d:00", hour];
		NSRect stringRect = {rectPos, oneHeaderSize};
		[hourStr drawInRect:stringRect withAttributes:headerAttr];
		// Draw Vertical lines for hours
		NSBezierPath *path = [[NSBezierPath alloc] init];
		[path setLineWidth:1.0];
		NSPoint startPt = NSMakePoint(initialLeft + hourNum * kHourWidth, myBounds.size.height);
		NSPoint endPt = NSMakePoint(initialLeft + hourNum * kHourWidth, 0);
		[path moveToPoint:startPt];
		[path lineToPoint:endPt];
		[path closePath];
		[path stroke];
		[path release];
	}
}

- (void) updateEvents: (NSArray *) events {
	[mon updateEvents: [events objectAtIndex:0]];
	[tue updateEvents: [events objectAtIndex:1]];
	[wed updateEvents: [events objectAtIndex:2]];
	[thu updateEvents: [events objectAtIndex:3]];
	[fri updateEvents: [events objectAtIndex:4]];

	// now the day views have resized themselves vertically, so resize me and reposition them to fit
	[self resizeWithOldSuperviewSize: NSMakeSize(0, 0)];

	short curTop = [self frame].size.height - kTopHeaderSpace;
	short curBottom = curTop - [mon frame].size.height;
	[mon setFrameOrigin:NSMakePoint(0, curBottom)];
	curBottom -= [tue frame].size.height;
	[tue setFrameOrigin:NSMakePoint(0, curBottom)];
	curBottom -= [wed frame].size.height;
	[wed setFrameOrigin:NSMakePoint(0, curBottom)];
	curBottom -= [thu frame].size.height;
	[thu setFrameOrigin:NSMakePoint(0, curBottom)];
	curBottom -= [fri frame].size.height;
	[fri setFrameOrigin:NSMakePoint(0, curBottom)];
}

- (void)resizeWithOldSuperviewSize:(NSSize)oldBoundsSize {
	// I must be at least as tall as my superview (the scrollview's content view)
	NSSize scrollContentSize = [(NSScrollView *)[[self superview] superview] contentSize];
	short neededHt = kTopHeaderSpace 
					+ [mon frame].size.height
					+ [tue frame].size.height
					+ [wed frame].size.height
					+ [thu frame].size.height
					+ [fri frame].size.height;
	short minHt = scrollContentSize.height;
	NSSize curSize = [self frame].size;
	short newHt = MAX(minHt, neededHt);
	[self setFrameSize:NSMakeSize(curSize.width, newHt)];
}

@end

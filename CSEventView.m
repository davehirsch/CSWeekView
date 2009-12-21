//
//  CSEventView.m
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

#import "CSEventView.h"
#import "CSWeekView.h"

@implementation CSEventView

@synthesize startTime, duration, color, label;

- (id) setupWithStartTime: (NSNumber *) inStartTime
				 duration: (NSNumber *) inDuration
					label: (NSString *) inLabel 
					color: (NSColor *) inColor {
	startTime = [inStartTime intValue];
	duration = [inDuration intValue];
	color = inColor;
	label = inLabel;
	return self;
}

- (id) initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	label = [[NSString string] retain];
	color = [NSColor blackColor];
	return self;
}

- (void) dealloc {
	[label release];
	[super dealloc];
}

- (void)drawRect:(NSRect)rect {
	NSColor *stringColor;
	float brightness = ([color redComponent] + [color greenComponent] + [color blueComponent]) / 3.0;
	if (brightness > 0.5) {
		stringColor = [NSColor blackColor];
	} else {
		stringColor = [NSColor whiteColor];
	}
	NSDictionary *eventAttr = [NSDictionary dictionaryWithObjectsAndKeys:
							   [NSFont systemFontOfSize:kHeaderFontSize], NSFontAttributeName,
								stringColor, NSForegroundColorAttributeName, nil];
	NSRect myBounds = [self bounds];
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:myBounds xRadius:myBounds.size.height/2.0 yRadius:myBounds.size.height/2.0];
	[color set];
    [path fill];
	[[NSColor blackColor] set];
	[path stroke];
	NSRect stringRect = NSInsetRect(myBounds, myBounds.size.height/2.0, 0);
	[label drawInRect:stringRect withAttributes:eventAttr];
}

@end

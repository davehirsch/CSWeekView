//
//  CSEventView.h
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

// This class handles drawing a single event

#import <Cocoa/Cocoa.h>

@interface CSEventView : NSView {
	short startTime;
	short duration;
	NSString *label;
	NSColor *color;
}

@property (assign) short startTime;
@property (assign) short duration;
@property (retain) NSString *label;
@property (assign) NSColor *color;

- (id) setupWithStartTime: (NSNumber *) inStartTime
				 duration: (NSNumber *) inDuration
					label: (NSString *) inLabel 
					color: (NSColor *) inColor;
@end

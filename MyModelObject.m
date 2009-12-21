//
//  myModelObject.m
//  CSWeekView Demo
//
//  Created by David Hirsch on 12/20/09.
//  Copyright 2009 Western Washington University. All rights reserved.
//

#import "MyModelObject.h"


@implementation MyModelObject
@synthesize color, name, startTime, duration, day;

- (id) init {
	self = [super init];
	color = [[NSColor redColor] retain];
	name = [[NSString stringWithFormat:@"default"] retain];
	day = 0;
	startTime = 0;
	duration  = 2;
	return self;
}

- (void) dealloc {
	[color release];
//	[name release];
	[super dealloc];
}

@end

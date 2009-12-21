//
//  myModelObject.h
//  CSWeekView Demo
//
//  Created by David Hirsch on 12/20/09.
//  Copyright 2009 Western Washington University. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MyModelObject : NSObject {
	NSColor *color;
	NSString	*name;
	short	startTime;
	short	duration;
	short	day;
}

@property (retain) NSColor *color;
@property (retain) NSString	*name;
@property (assign) short	startTime;
@property (assign) short	duration;
@property (assign) short	day;

@end

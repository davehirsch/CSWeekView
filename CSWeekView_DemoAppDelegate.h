//
//  CSWeekView_DemoAppDelegate.h
//  CSWeekView Demo
//
//  Created by David Hirsch on 12/20/09.
//  Copyright 2009 Western Washington University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class CSWeekView;

@interface CSWeekView_DemoAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet NSArrayController *myArrayController;
	NSMutableArray *theModelObjects;
	IBOutlet CSWeekView *theWeekView;
}

- (IBAction) updateWeekView: (id) sender;

@property (retain) NSMutableArray *theModelObjects;
@property (assign) IBOutlet NSWindow *window;

@end

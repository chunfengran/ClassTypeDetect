//
//  AppDelegate.m
//  TypeDetect
//
//  Created by wangdazhitech on 9/11/15.
//  Copyright (c) 2015 wangdazhi. All rights reserved.
//

#import "AppDelegate.h"
#import "RFDBHelper.h"
#import "RFDemoNumber.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	//[demoOne setValue:[NSNumber numberWithFloat:23.2] forKey:@"onefloat"];
	
	NSLog(@"%@",[RFDBHelper classGetPropertyList:[RFDemoNumber class]]);
	NSLog(@"%@",[RFDBHelper classGetPropertyList:[NSWindow class]]);
	
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

@end

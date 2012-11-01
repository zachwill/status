//
//  HRKAppDelegate.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKAppDelegate.h"
#import "HRKStatusViewController.h"
#import "HRKTableViewController.h"
#import "HRKTheme.h"

@implementation HRKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Root view controller
    HRKTableViewController *tableViewController = [[HRKTableViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    [self.window makeKeyAndVisible];
    
    // UIAppearance styling
    [HRKTheme applyCustomStyleSheet];
    
    return YES;
}

@end

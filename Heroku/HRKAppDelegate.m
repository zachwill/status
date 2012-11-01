//
//  HRKAppDelegate.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKAppDelegate.h"
#import "HRKIssuesViewController.h"
#import "AFNetworking.h"
#import "HRKTheme.h"

@implementation HRKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // AFNetworking activity indicator
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // Root view controller
    HRKIssuesViewController *issuesVC = [[HRKIssuesViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:issuesVC];
    [self.window makeKeyAndVisible];
    
    // UIAppearance styling
    [HRKTheme applyCustomStyleSheet];
    
    return YES;
}

@end

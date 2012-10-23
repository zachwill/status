//
//  HRKAppDelegate.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKAppDelegate.h"
#import "HRKStatusViewController.h"

@implementation HRKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Root view controller
    HRKStatusViewController *herokuVC = [[HRKStatusViewController alloc] initWithNibName:@"HRKStatusViewController"
                                                                                  bundle:nil];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:herokuVC];
    [self.window makeKeyAndVisible];
    
    // UIAppearance styling
    [self applyStyleSheet];
    
    return YES;
}

- (void)applyStyleSheet {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav"]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"nav_shadow"]];
}

@end

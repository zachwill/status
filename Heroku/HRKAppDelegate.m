//
//  HRKAppDelegate.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKAppDelegate.h"
#import "AFNetworking.h"
#import "HRKDataModel.h"
#import "HRKTheme.h"
#import "HRKIssuesViewController.h"
#import "HRKIssuesCollectionViewController.h"
#import "HRKIssueLayout.h"
#import "Reachability.h"

@implementation HRKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // AFNetworking activity indicator
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // Create NSURL cache
    [[HRKDataModel sharedModel] createSharedURLCache];
    
    // Root view controller
    HRKIssueLayout *layout = [[HRKIssueLayout alloc] init];
    HRKIssuesCollectionViewController *issuesVC = [[HRKIssuesCollectionViewController alloc] initWithCollectionViewLayout:layout];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:issuesVC];
    [self.window makeKeyAndVisible];
    
    // UIAppearance styling
    [HRKTheme applyCustomStyleSheet];
    
    // Check network reachability
    [self checkNetworkReachability];
    
    return YES;
}

- (void)checkNetworkReachability {
    Reachability *heroku = [Reachability reachabilityWithHostname:@"http://status.heroku.com"];
    heroku.unreachableBlock = ^(Reachability *reach){
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Internet Connection Failed"
                                        message:@"Sorry, looks like the connection failed."
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        });
    };
    [heroku startNotifier];
}

@end

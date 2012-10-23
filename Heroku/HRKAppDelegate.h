//
//  HRKAppDelegate.h
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRKViewController;

@interface HRKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HRKViewController *viewController;

@end

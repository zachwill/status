//
//  HRKAppearance.m
//  Heroku
//
//  Created by Zach Williams on 10/31/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKTheme.h"

@implementation HRKTheme

+ (UIColor *)backgroundColor {
    // #21212A
    return [UIColor colorWithRed:0.129 green:0.129 blue:0.165 alpha:1.000];
}

+ (UIColor *)purpleColor {
    // #29254d
    return [UIColor colorWithRed:0.161 green:0.145 blue:0.302 alpha:1.000];
}

+ (UIColor *)textColor {
    // #8577d6
    return [UIColor colorWithRed:0.522 green:0.467 blue:0.839 alpha:1.000];
}

+ (void)applyCustomStyleSheet {
    // Navigation
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav"]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"nav_shadow"]];
    
    // Back Button
    UIImage *backbutton = [[UIImage imageNamed:@"back.png"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backbutton
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
}

@end

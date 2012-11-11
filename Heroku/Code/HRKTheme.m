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

+ (UIColor *)darkBackgroundColor {
    // #230824
    return [UIColor colorWithRed:0.137 green:0.031 blue:0.141 alpha:1.000];
}

+ (UIColor *)orangeColor {
    // #efbf56
    return [UIColor colorWithRed:0.937 green:0.749 blue:0.337 alpha:1.000];
}

+ (UIColor *)purpleColor {
    // #33153b
    return [UIColor colorWithRed:0.200 green:0.082 blue:0.231 alpha:1.000];
}

+ (UIColor *)contentBackgroundColor {
    // #351a38
    return [UIColor colorWithRed:0.208 green:0.102 blue:0.220 alpha:1.000];
}

+ (UIColor *)textColor {
    // #9b9aba
    return [UIColor colorWithRed:0.467 green:0.396 blue:0.478 alpha:1.000];
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

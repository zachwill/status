//
//  UIColor+Heroku.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "UIColor+Heroku.h"

@implementation UIColor (Heroku)

+ (UIColor *)hrk_backgroundColor {
    // #21212A
    return [UIColor colorWithRed:0.129 green:0.129 blue:0.165 alpha:1.000];
}

+ (UIColor *)hrk_repeatingBackground {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"repeating"]];
}

@end

//
//  HRKAppearance.h
//  Heroku
//
//  Created by Zach Williams on 10/31/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRKTheme : NSObject

+ (void)applyCustomStyleSheet;

+ (UIColor *)backgroundColor;
+ (UIColor *)darkBackgroundColor;
+ (UIColor *)orangeColor;
+ (UIColor *)purpleColor;
+ (UIColor *)grayColor;
+ (UIColor *)textColor;

@end

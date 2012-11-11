//
//  HRKUpdateHeaderView.m
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdateHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HRKUpdateHeaderView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.headerBar.bounds
                                               byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.headerBar.bounds;
    maskLayer.path = path.CGPath;
    self.headerBar.layer.mask = maskLayer;
}

@end

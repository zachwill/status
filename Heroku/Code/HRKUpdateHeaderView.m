//
//  HRKUpdateHeaderView.m
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdateHeaderView.h"

@implementation HRKUpdateHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.issueName.textAlignment = NSTextAlignmentCenter;
    return self;
}

@end

//
//  HRKIssueCollectionView.m
//  Heroku
//
//  Created by Zach Williams on 11/5/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssueCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "HRKTheme.h"

@implementation HRKIssueCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor  = [HRKTheme purpleColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.contentView.layer.cornerRadius = 14;
    return self;
}

- (void)setIssue:(Issue *)issue {
    // Apply the right labels.
}

@end

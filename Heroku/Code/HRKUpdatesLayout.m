//
//  HRKUpdatesLayout.m
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdatesLayout.h"

static const CGFloat kCellWidth = 300;
static const CGFloat kCellHeight = 175;
static const CGFloat kHeaderHeight = 55;

@implementation HRKUpdatesLayout

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.itemSize = CGSizeMake(kCellWidth, kCellHeight);
    self.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    self.minimumLineSpacing = 1;
    self.headerReferenceSize = CGSizeMake(kCellWidth, kHeaderHeight);
    return self;
}

@end

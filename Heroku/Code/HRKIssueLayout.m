//
//  HRKIssueLayout.m
//  Heroku
//
//  Created by Zach Williams on 11/5/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssueLayout.h"

@implementation HRKIssueLayout

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.itemSize = CGSizeMake(300, 130);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 16;
    return self;
}

@end

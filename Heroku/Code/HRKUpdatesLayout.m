//
//  HRKUpdatesLayout.m
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdatesLayout.h"

@implementation HRKUpdatesLayout

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.itemSize = CGSizeMake(300, 200);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 1;
    return self;
}

@end

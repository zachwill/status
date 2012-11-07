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
    
    self.itemSize = CGSizeMake(300, 175);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 1;
    self.headerReferenceSize = CGSizeMake(300, 75);
    return self;
}

@end

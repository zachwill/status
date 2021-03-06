//
//  HRKUpdatesCollectionViewController.h
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Issue;

@interface HRKUpdatesViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) Issue *issue;
@property (nonatomic, strong) NSOrderedSet *updates;

- (id)initWithIssue:(Issue *)issue;

@end

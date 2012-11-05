//
//  HRKIssuesCollectionViewController.h
//  Heroku
//
//  Created by Zach Williams on 11/5/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRKIssuesViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UIRefreshControl *refreshControl;

@end

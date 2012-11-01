//
//  HRKUpdatesViewController.h
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Issue;

@interface HRKUpdatesViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSOrderedSet *updates;

- (id)initWithIssue:(Issue *)issue;

@end

//
//  HRKTableViewController.h
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRKIssuesViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

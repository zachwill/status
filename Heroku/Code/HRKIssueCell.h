//
//  HRKIssueCell.h
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Issue;

@interface HRKIssueCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *description;
@property (nonatomic, weak) IBOutlet UILabel *duration;
@property (nonatomic, strong) Issue *issue;

@end

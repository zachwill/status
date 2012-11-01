//
//  HRKIssueCell.m
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssueCell.h"
#import "Issue.h"

@implementation HRKIssueCell

- (void)setIssue:(Issue *)issue {
    self.title.text = issue.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

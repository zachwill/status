//
//  HRKIssueCell.m
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssueCell.h"
#import "Issue.h"
#import "Update.h"

@implementation HRKIssueCell

- (void)setIssue:(Issue *)issue {
    self.title.text = issue.title;
    self.description.text = [issue.updates[0] contents];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

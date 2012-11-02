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
    Update *mostRecentUpdate = issue.updates[0];
    self.description.text = mostRecentUpdate.contents;
    NSDateComponents *duration = issue.duration;
    if (duration.hour > 0 && duration.hour < 12) {
        // Seems to be a crazy bug -- hundreds of hours?
        self.duration.text = [NSString stringWithFormat:@"%dh", duration.hour];
    } else {
        self.duration.text = [NSString stringWithFormat:@"%dm", duration.minute];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

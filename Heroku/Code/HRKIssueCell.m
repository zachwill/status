//
//  HRKIssueCollectionView.m
//  Heroku
//
//  Created by Zach Williams on 11/5/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssueCell.h"
#import <QuartzCore/QuartzCore.h>
#import "HRKTheme.h"
#import "Issue.h"
#import "Update.h"
#import "TTTTimeIntervalFormatter.h"

@implementation HRKIssueCell

- (void)applyStyles {
    self.layer.cornerRadius = 3;
    self.backgroundColor = [HRKTheme contentBackgroundColor];
    self.duration.textColor = [HRKTheme orangeColor];
}

- (void)setIssue:(Issue *)issue {
    _issue = issue;
    self.title.text = _issue.title;

    Update *mostRecentUpdate = _issue.updates[0];
    self.description.text = mostRecentUpdate.contents;

    static NSDateComponents *duration = nil;
    duration = _issue.duration;
    if (duration.hour > 0 && duration.hour < 12) {
        // Seems to be a crazy bug -- hundreds of hours?
        self.duration.text = [NSString stringWithFormat:@"%dh", duration.hour];
    } else {
        self.duration.text = [NSString stringWithFormat:@"%dm", duration.minute];
    }
    
    static TTTTimeIntervalFormatter *timeFormatter = nil;
    timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
    NSString *timeStamp = [timeFormatter stringForTimeInterval:[_issue.updated_at timeIntervalSinceDate:[NSDate date]]];
    self.timeStamp.text = timeStamp;
}

- (void)setSelected:(BOOL)selected {
    if (!self.titleBar.highlighted) {
        self.titleBar.highlighted = NO;
    }
    [super setSelected:selected];
}

@end

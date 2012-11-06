//
//  HRKUpdateCollectionCell.m
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdateCollectionCell.h"
#import "TTTTimeIntervalFormatter.h"
#import "Update.h"

@implementation HRKUpdateCollectionCell

- (void)setUpdate:(Update *)update {
    _update = update;
    self.title.text = [_update.update_type capitalizedString];
    self.description.text = _update.contents;
    TTTTimeIntervalFormatter *formatter = [[TTTTimeIntervalFormatter alloc] init];
    self.timeStamp.text = [formatter stringForTimeInterval:[_update.created_at timeIntervalSinceDate:[NSDate date]]];
}

@end

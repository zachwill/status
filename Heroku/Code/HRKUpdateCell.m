//
//  HRKUpdateCell.m
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdateCell.h"
#import "Update.h"

@implementation HRKUpdateCell

- (void)setUpdate:(Update *)update {
    _update = update;
    self.title.text = [update.update_type capitalizedString];
    self.contents.text = update.contents;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

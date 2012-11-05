//
//  HRKIssueCollectionView.h
//  Heroku
//
//  Created by Zach Williams on 11/5/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Issue;

@interface HRKIssueCell : UICollectionViewCell

@property (nonatomic, strong) Issue *issue;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *description;
@property (nonatomic, weak) IBOutlet UILabel *duration;
@property (nonatomic, weak) IBOutlet UIImageView *titleBar;

- (void)applyStyles;

@end

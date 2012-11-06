//
//  HRKUpdateCollectionCell.h
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Update;

@interface HRKUpdateCollectionCell : UICollectionViewCell

@property (nonatomic, strong) Update *update;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *description;
@property (nonatomic, weak) IBOutlet UILabel *timeStamp;

@end

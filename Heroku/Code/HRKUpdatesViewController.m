//
//  HRKUpdatesCollectionViewController.m
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdatesViewController.h"
#import <CoreData/CoreData.h>
#import "Issue.h"
#import "Update.h"
#import "HRKUpdatesLayout.h"
#import "HRKUpdateCollectionCell.h"
#import "HRKUpdateHeaderView.h"
#import "HRKTheme.h"

// ***************************************************************************

@interface HRKUpdatesViewController ()

@end

// ***************************************************************************

enum UIAlertViewButton {
    UIAlertViewOkButton = 1
};

static NSString * const kUpdateCellIdentifier = @"Update";
static NSString * const kUpdatesHeaderIdentifier = @"Updates Header";
static NSString * const kHerokuStatusURL = @"https://status.heroku.com/incidents/";

// ***************************************************************************

@implementation HRKUpdatesViewController

#pragma mark - UIViewController

- (id)initWithIssue:(Issue *)issue {
    self = [super initWithCollectionViewLayout:[[HRKUpdatesLayout alloc] init]];
    if (!self) {
        return nil;
    }

    self.issue = issue;
    self.updates = issue.updates;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"HRKUpdateCollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:kUpdateCellIdentifier];
    self.collectionView.backgroundColor = [HRKTheme darkBackgroundColor];
    self.collectionView.alwaysBounceVertical = YES;
    
    // Issue header
    UINib *header = [UINib nibWithNibName:@"HRKUpdateHeaderView" bundle:nil];
    [self.collectionView registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUpdatesHeaderIdentifier];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heroku.png"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:self
                                                                                           action:@selector(shareIssue:)];
    
    // Gesture Recognizer
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:swipe];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.updates.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HRKUpdateCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kUpdateCellIdentifier forIndexPath:indexPath];
    Update *update = self.updates[indexPath.item];
    cell.backgroundColor = [HRKTheme contentBackgroundColor];
    cell.update = update;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        HRKUpdateHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                         withReuseIdentifier:kUpdatesHeaderIdentifier
                                                                                forIndexPath:indexPath];
        Issue *issue = [self.updates[0] issue];
        header.issueName.text = issue.title;
        return header;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Update *update = self.updates[indexPath.item];
    CGSize constraint = CGSizeMake(280, MAXFLOAT);
    CGSize text = [update.contents sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:constraint];
    return CGSizeMake(300, 75 + text.height);
}

#pragma mark - UIGestureRecognizer

- (void)swiped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIActivity

- (void)shareIssue:(id)sender {
    NSArray *items = @[[NSURL URLWithString:[NSString stringWithFormat:@"https://status.heroku.com/incidents/%@", self.issue.issue_id]]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    activityVC.excludedActivityTypes = @[
        UIActivityTypeAssignToContact,
        UIActivityTypeCopyToPasteboard,
        UIActivityTypePostToFacebook,
        UIActivityTypePostToWeibo,
        UIActivityTypePrint
    ];
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end

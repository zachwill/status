//
//  HRKUpdatesCollectionViewController.m
//  Heroku
//
//  Created by Zach Williams on 11/6/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdatesCollectionViewController.h"
#import <CoreData/CoreData.h>
#import "Issue.h"
#import "Update.h"
#import "HRKUpdatesLayout.h"
#import "HRKUpdateCollectionCell.h"
#import "HRKTheme.h"

// ***************************************************************************

@interface HRKUpdatesCollectionViewController () <UIAlertViewDelegate>

@end

// ***************************************************************************

enum UIAlertViewButton {
    UIAlertViewOkButton = 1
};

static NSString * const kUpdateCellIdentifier = @"Update";

// ***************************************************************************

@implementation HRKUpdatesCollectionViewController

- (id)initWithIssue:(Issue *)issue {
    self = [super initWithCollectionViewLayout:[[HRKUpdatesLayout alloc] init]];
    if (!self) {
        return nil;
    }
    self.updates = issue.updates;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"HRKUpdateCollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:kUpdateCellIdentifier];
    self.collectionView.backgroundColor = [HRKTheme darkBackgroundColor];
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
    cell.backgroundColor = [HRKTheme grayColor];
    cell.update = update;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[[UIAlertView alloc] initWithTitle:@"Open Safari"
                                message:@"Open Issue in Safari?"
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"OK", nil] show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    static Update *update = nil;
    update = self.updates[0];
    NSURL *heroku  = [NSURL URLWithString:[NSString stringWithFormat:@"https://status.heroku.com/incidents/%@", update.incident_id]];
    
    switch (buttonIndex) {
        case UIAlertViewOkButton:
            [[UIApplication sharedApplication] openURL:heroku];
            break;
    }
}

@end

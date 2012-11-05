//
//  HRKIssuesCollectionViewController.m
//  Heroku
//
//  Created by Zach Williams on 11/5/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssuesCollectionViewController.h"
#import <CoreData/CoreData.h>
#import "HRKDataModel.h"
#import "Issue.h"
#import "HRKTheme.h"
#import "HRKIssueCollectionViewCell.h"
#import "HRKUpdatesViewController.h"

// ***************************************************************************

@interface HRKIssuesCollectionViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

// ***************************************************************************

static NSString * const kReuseIdentifier = @"Issue";

// ***************************************************************************

@implementation HRKIssuesCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [HRKTheme backgroundColor];
    UINib *collectionViewCell = [UINib nibWithNibName:@"HRKIssueCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:collectionViewCell forCellWithReuseIdentifier:kReuseIdentifier];
    [self.collectionView addSubview:self.refreshControl];
    [self refetchData];
}

#pragma mark - UIRefreshControl

- (UIRefreshControl *)refreshControl {
    if (_refreshControl != nil) {
        return _refreshControl;
    }
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [HRKTheme purpleColor];
    [refreshControl addTarget:self action:@selector(refetchData) forControlEvents:UIControlEventValueChanged];
    _refreshControl = refreshControl;
    return _refreshControl;
}

#pragma mark - NSFetchedResultsController

- (void)refetchData {
    [self.fetchedResultsController performFetch:nil];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Issue"];
    fetch.fetchBatchSize = 10;
    fetch.returnsObjectsAsFaults = NO;
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"href" ascending:NO]];
    NSManagedObjectContext *context = [[HRKDataModel sharedModel] mainContext];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch
                                                                    managedObjectContext:context
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:@"Issue"];
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HRKIssueCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    Issue *issue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.backgroundColor = [HRKTheme purpleColor];
    cell.issue = issue;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Issue *issue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    HRKUpdatesViewController *updatesViewController = [[HRKUpdatesViewController alloc] initWithIssue:issue];
    [self.navigationController pushViewController:updatesViewController animated:YES];
}

@end

//
//  HRKIssuesCollectionViewController.m
//  Heroku
//
//  Created by Zach Williams on 11/5/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssuesViewController.h"
#import <CoreData/CoreData.h>
#import "AFNetworking.h"
#import "HRKDataModel.h"
#import "Issue.h"
#import "HRKTheme.h"
#import "HRKIssueCell.h"
#import "HRKCurrentStatus.h"
#import "HRKUpdatesViewController.h"
#import "HRKUpdatesViewController.h"

// ***************************************************************************

@interface HRKIssuesViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

// ***************************************************************************

static NSString * const kReuseIdentifier  = @"Issue";
static NSString * const kHeaderIdentifier = @"Header";
static NSString * const kHerokuCurrentStatusURL = @"https://status.heroku.com/api/v3/current-status";

// ***************************************************************************

@implementation HRKIssuesViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [HRKTheme darkBackgroundColor];
    self.collectionView.alwaysBounceVertical = YES;
    UINib *collectionViewCell = [UINib nibWithNibName:@"HRKIssueCell" bundle:nil];
    [self.collectionView registerNib:collectionViewCell forCellWithReuseIdentifier:kReuseIdentifier];
    
    UINib *header = [UINib nibWithNibName:@"HRKCurrentStatus" bundle:nil];
    [self.collectionView registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
    
    [self.collectionView addSubview:self.refreshControl];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heroku.png"]];

    [self refetchData];
    [self customBackButton];
}

- (void)customBackButton {
    UIImage *arrow = [UIImage imageNamed:@"arrow.png"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:arrow style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
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
    [self checkCurrentHerokuStatus];
    
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
    _fetchedResultsController.delegate = self;
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
    HRKIssueCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    Issue *issue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.issue = issue;
    [cell applyStyles];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        identifier = kHeaderIdentifier;
    }
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Issue *issue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    HRKUpdatesViewController *updatesVC = [[HRKUpdatesViewController alloc] initWithIssue:issue];
    [self.navigationController pushViewController:updatesVC animated:YES];
}

#pragma mark - AFNetworking

- (void)checkCurrentHerokuStatus {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kHerokuCurrentStatusURL]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSDictionary *status = [JSON objectForKey:@"status"];
            NSLog(@"%@", status);
        } failure:nil];
        [operation start];
    });
}

@end

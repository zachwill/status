//
//  HRKTableViewController.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKTableViewController.h"
#import <CoreData/CoreData.h>
#import "HRKDataModel.h"
#import "HRKTheme.h"
#import "Issue.h"
#import "HRKIssueCell.h"

@interface HRKTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end


static NSString * const kCellIdentifier = @"Issue";


@implementation HRKTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createRefreshControl];
    self.tableView.backgroundColor = [HRKTheme backgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HRKIssueCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    [self refreshData];
}

- (void)createRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [HRKTheme purpleColor];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.tableView addSubview:self.refreshControl];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Issue"];
    NSManagedObjectContext *context = [[HRKDataModel sharedModel] mainContext];
    fetchRequest.fetchBatchSize = 30;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"href" ascending:NO]];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:context
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:@"Issue"];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

- (void)refreshData {
    [self.fetchedResultsController performSelectorOnMainThread:@selector(performFetch:)
                                                    withObject:nil
                                                 waitUntilDone:YES
                                                         modes:@[NSRunLoopCommonModes]];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
   }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HRKIssueCell *cell = (HRKIssueCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    Issue *issue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.title.text = issue.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     // Pass the selected object to the new view controller.
     // [self.navigationController pushViewController:detailViewController animated:YES];
}

@end

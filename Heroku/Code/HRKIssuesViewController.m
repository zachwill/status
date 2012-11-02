//
//  HRKTableViewController.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIssuesViewController.h"
#import <CoreData/CoreData.h>
#import "HRKDataModel.h"
#import "HRKTheme.h"
#import "Issue.h"
#import "HRKIssueCell.h"
#import "HRKIssueHeaderView.h"
#import "HRKUpdatesViewController.h"

@interface HRKIssuesViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end


static NSString * const kCellIdentifier = @"Issue";
static const CGFloat kCellHeight = 125.0f;


@implementation HRKIssuesViewController

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
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"href" ascending:NO]];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:context
                                                                      sectionNameKeyPath:@"day"
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
    cell.issue = issue;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionName = [[self.fetchedResultsController.sections objectAtIndex:section] name];
    static NSDateFormatter *rawDateFormatter = nil;
    static NSDateFormatter *dateStringFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rawDateFormatter = [[NSDateFormatter alloc] init];
        rawDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZ";
        dateStringFormatter = [[NSDateFormatter alloc] init];
        dateStringFormatter.dateFormat = @"E MMM d";
    });
    NSDate *date  = [rawDateFormatter dateFromString:sectionName];
    NSString *day = [dateStringFormatter stringFromDate:date];
    HRKIssueHeaderView *header = (HRKIssueHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"HRKIssueHeaderView"
                                                                                      owner:self
                                                                                    options:nil] lastObject];
    header.backgroundColor = [UIColor colorWithRed:0.157 green:0.161 blue:0.212 alpha:1.000];
    header.day.text = day;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Issue *issue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    HRKUpdatesViewController *updatesViewController = [[HRKUpdatesViewController alloc] initWithIssue:issue];
    [self.navigationController pushViewController:updatesViewController animated:YES];
}

@end

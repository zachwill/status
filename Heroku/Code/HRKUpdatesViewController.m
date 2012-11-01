//
//  HRKUpdatesViewController.m
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKUpdatesViewController.h"
#import <CoreData/CoreData.h>
#import "Issue.h"
#import "Update.h"
#import "HRKUpdateCell.h"
#import "HRKTheme.h"

@interface HRKUpdatesViewController ()

@end

static NSString * const kUpdateCellIdentifier = @"Update";

@implementation HRKUpdatesViewController

- (id)initWithIssue:(Issue *)issue {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.updates = issue.updates;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"HRKUpdateCell" bundle:nil] forCellReuseIdentifier:kUpdateCellIdentifier];
    self.tableView.backgroundColor = [HRKTheme backgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.updates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HRKUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:kUpdateCellIdentifier forIndexPath:indexPath];
    
    Update *update = [self.updates objectAtIndex:indexPath.item];
    cell.update = update;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Should there be any interaction?
}

@end

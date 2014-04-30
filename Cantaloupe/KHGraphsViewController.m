//
//  KHGraphsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGraphsViewController.h"
#import "KHGraphsViewCell.h"

static NSString *kGraphsCellIdentifier = @"kGraphsCell";

@interface KHGraphsViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KHGraphsViewController

#pragma mark - NSObject

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

#pragma mark - UIViewController
- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Graphs", nil);
    [self.tableView registerClass:[KHGraphsViewCell class] forCellReuseIdentifier:kGraphsCellIdentifier];
}

#pragma mark - UITableView protocols

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHGraphsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGraphsCellIdentifier forIndexPath:indexPath];
    
    [self customizeCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)customizeCell:(KHGraphsViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        cell.textLabel.text = NSLocalizedString(@"Purchases", nil);
        
    } else if (row == 1) {
        cell.textLabel.text = NSLocalizedString(@"Views", nil);
        
    } else if (row == 2) {
        cell.textLabel.text = NSLocalizedString(@"Downloads", nil);
    }
    
}




@end

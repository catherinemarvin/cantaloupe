//
//  KHSettingsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/1/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHSettingsViewController.h"
#import "KHSettingsViewCell.h"
#import "KHSessionController.h"

static NSString *kSettingsCellIdentifier = @"kSettingsCell";
static CGFloat kSectionHeaderHeight = 40.0f;

typedef NS_ENUM(NSUInteger, KHSettingsCells) {
    KHSettingCellNone,
    KHSettingCellLogout,
    KHSettingCellUsername
};

@interface KHSettingsViewController ()

@property (nonatomic, strong) NSArray *settingItems;
@property (nonatomic, strong )NSArray *userItems;

@end

@implementation KHSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.settingItems = @[@(KHSettingCellLogout)];
        self.userItems = @[@(KHSettingCellUsername)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Settings", nil);
    [self.tableView registerClass:[KHSettingsViewCell class] forCellReuseIdentifier:kSettingsCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.settingItems.count;
    } else {
        return self.userItems.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, kSectionHeaderHeight)];
    CGFloat leftPadding = 15.0f;
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 0.0f, tableView.frame.size.width - leftPadding, kSectionHeaderHeight)];
    NSString *text;
    if (section == 0) {
        text = NSLocalizedString(@"Account management", nil);
    } else {
        text = NSLocalizedString(@"Account information", nil);
    }
    header.text = text;
    [headerView addSubview:header];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KHSettingsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingsCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [self customizeCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)customizeCell:(KHSettingsViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    KHSettingsCells cellType = KHSettingCellNone;
    
    NSArray *backingData;
    if (indexPath.section == 0) {
        backingData = self.settingItems;
    } else {
        backingData = self.userItems;
    }
    
    NSInteger row = indexPath.row;
    if (row < backingData.count) {
        cellType = (KHSettingsCells) [backingData[row] unsignedIntegerValue];
    }
    
    switch (cellType) {
        case KHSettingCellLogout:
            cell.textLabel.text = @"Logout";
            cell.tag = KHSettingCellLogout;
            break;
        case KHSettingCellUsername:
            cell.textLabel.text = NSLocalizedString(@"Username", nil);
            cell.detailTextLabel.text = [[KHSessionController sharedInstance] username];
            cell.tag = KHSettingCellUsername;
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.tag) {
        case KHSettingCellLogout:
            [[KHSessionController sharedInstance] logout];
            break;
        default:
            break;
    }
}

@end
